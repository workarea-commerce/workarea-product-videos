/**
 * @namespace WORKAREA.youtubeApi
 */
WORKAREA.registerModule('youtubeApi', (function () {
    'use strict';

    var getAnalyticsLabel = function(iframe) {
            var iframeSrc = iframe.attr('src').split('?')[0],
                label = iframeSrc;

            if (iframe.data('title')) {
                label += ' (' + iframe.data('title') + ')';
            } else if (iframe.attr('title')) {
                label += ' (' + iframe.attr('title') + ')';
            }

            return label;
        },

        sendEvent = function (id, action) {
            var iframe = $('#' + id),
                label = getAnalyticsLabel(iframe);

            WORKAREA.analytics.fireCallback(
                'youtube',
                {
                    'eventCategory': 'Youtube',
                    'eventAction': action,
                    'eventLabel': label,
                    'eventValue': undefined
                }
            );
        },

        onPlay = function (playerId) {
            sendEvent(playerId, 'Play Video');
        },

        onPause = function (playerId) {
            sendEvent(playerId, 'Paused video');
        },

        onFinish = function (playerId) {
            sendEvent(playerId, 'Completed video');
        },

        handlePlayerState = function(playerId, state) {
            var stateMap = {
                    '-1': 'unstarted',
                    '0': 'ended',
                    '1': 'playing',
                    '2': 'paused',
                    '3': 'buffering',
                    '5': 'queued'
                },
                currentState = stateMap[state.data];

            if (currentState === 'playing') {
                onPlay(playerId);
            } else if (currentState === 'paused') {
                onPause(playerId);
            } else if (currentState === 'ended') {
                onFinish(playerId);
            }
        },

        onPlayerReady = function (playerData, event) {
            var player = event.target;

            if (playerData.mute === 'true') {
                player.mute();
            }
        },

        setupPlayer = function (index, iframe) {
            var playerData = $(iframe).data('youtubeApi'),
                playerId = $(iframe).attr('id'),
                player = new YT.Player(playerId, {
                    events: {
                        'onReady': _.partial(onPlayerReady, playerData),
                        'onStateChange': _.partial(handlePlayerState, playerId)
                    }
                });

            return player;
        },

        scriptLoaded = function ($scope) {
            var $youtubeIframes = $('[data-youtube-api]', $scope);

            $youtubeIframes.each(setupPlayer);
        },

        injectSDK = function () {
            if ($('[data-youtube-api]').data('youtube-api-loaded')) {
                return;
            } else {
                $.getScript('https://www.youtube.com/player_api');
            }
        },

        init = function ($scope) {
            var $youtubeIframes = $('[data-youtube-api]', $scope);

            if (_.isEmpty($youtubeIframes)) { return; }

            injectSDK();
        };

    return {
        init: init,
        scriptLoaded: scriptLoaded
    };
}()));

/**
 * onYouTubeIframeAPIReady is called by YouTube API
 * This is executed when the API is ready to go.
 */
/*eslint no-unused-vars: 0 */
function onYouTubeIframeAPIReady() {
    $('[data-youtube-api]').data('youtube-api-loaded', true);
    WORKAREA.youtubeApi.scriptLoaded($(document));
}
