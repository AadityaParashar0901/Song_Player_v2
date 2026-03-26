$Console:Only
OutputFile$ = MapNew$
MapSetKey OutputFile$, "current_playlist", MKL$(1)
MapSetKey OutputFile$, "current_song", MKL$(1)
MapSetKey OutputFile$, "current_position", MKL$(0)
MapSetKey OutputFile$, "volume", MKI$(100)
MapSetKey OutputFile$, "repeat_mode", Chr$(0)
PlayLists$ = ListStringNew
If _FileExists(Command$) Then
    Open Command$ For Input As #1
    OFile$ = ChangeFileExtension(Command$, ".dat")
ElseIf _FileExists("Song_Player.txt") Then
    Open "Song_Player.txt" For Input As #1
    OFile$ = "Song_Player.dat"
Else
    System
End If
While EOF(1) = 0
    M$ = MapNew
    Input #1, PN$, N~&
    MapSetKey M$, "name", PN$
    SongNames$ = ListStringNew$
    SongPaths$ = ListStringNew$
    SongTimes$ = ""
    For I = 1 To N~&
        Input #1, N$, P$, V~%, T~&
        ListStringAdd SongNames$, N$
        ListStringAdd SongPaths$, P$
        SongTimes$ = SongTimes$ + MKL$(T~&)
    Next I
    MapSetKey M$, "song_names", SongNames$
    MapSetKey M$, "song_paths", SongPaths$
    MapSetKey M$, "song_times", SongTimes$
    ListStringAdd PlayLists$, M$
Wend
Close #1
MapSetKey OutputFile$, "playlists", PlayLists$
OutputFile$ = _Deflate$(OutputFile$)
Open OFile$ For Output As #1
Print #1, OutputFile$;
Close #1
System
'$Include:'include\dsa\liststring.bas'
'$Include:'include\dsa\map.bas'
'$Include:'include\changefileextension.bm'
