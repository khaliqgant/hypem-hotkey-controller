on run
    tell application "Google Chrome"

        set seenPlayerTab to 0

        set thisWindowIndex to 1
        repeat with thisWindow in windows

            set thisTabIndex to 1
            repeat with thisTab in tabs of thisWindow

                if URL of thisTab starts with "https://hypem.com/" then
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
            execute javascript "
            function eventFire(el, etype){
                if (el.fireEvent) {
                    el.fireEvent('on' + etype);
                } else {
                    var evObj = document.createEvent('Events');
                    evObj.initEvent(etype, true, false);
                    el.dispatchEvent(evObj);
                }
            }
            function previous(){
                var control = document.getElementById('playerPrev');
                eventFire(control,'click');
                var infoNode = document.getElementById('player-nowplaying').childNodes;
                var artist = infoNode[0].text;
                var seperator = infoNode[1].text;
                var track = infoNode[2].text;
                var string = 'Now Playing' + ' : ' + artist + seperator + track;

                return string;
            } 
            previous();
            "
        end tell

    end tell
end run
