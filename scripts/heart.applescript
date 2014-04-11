on run
    tell application "Google Chrome"

        set seenPlayerTab to 0

        set thisWindowIndex to 1
        repeat with thisWindow in windows

            set thisTabIndex to 1
            repeat with thisTab in tabs of thisWindow

                if URL of thisTab starts with "http://hypem.com/" then
                    set seenPlayerTab to 1
                    exit repeat
                end if

                set thisTabIndex to thisTabIndex + 1

            end repeat

            if seenPlayerTab is greater than 0 then
                exit repeat
            end if

            set thisWindowIndex to thisWindowIndex + 1

        end repeat

        tell tab thisTabIndex of window thisWindowIndex
            execute javascript "function fav(){
                $('#playerFav').click()
                var result = 'Unloved';
                var status = $('#playerFav').hasClass('fav-on');
                if (status)
                    var result = 'Loved';
                var artist = $('#player-nowplaying').find('a').first().text();
                var track = $('#player-nowplaying').children('a').eq(1).text();
                var complete = 'Just ' + result + ' : ' + artist + ' - ' + track;
                return complete;
                } fav();"
        end tell

    end tell
end run
