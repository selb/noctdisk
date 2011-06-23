#Translated by Mateusz Viste "Fox" / the.killer@wp.pl
#Polish letters encoded in the MAZOVIA standard
#Homepage: http://www.the.killer.webpark.pl/en/fdos_pl.htm
#
# fatal errors
0.0:Brak pamiëci. Brakuje %ld bajt¢w.\n
0.1:SYSTEM MEMORY TRASHED! (int 21.5803 failure)\n
0.2:UMB Corruption: Chain doesn't reach top of low RAM at %dk. Last=0x%x.\n
0.3:The MCB chain is corrupted (no Z MCB after last M MCB, but %c at seg 0x%x).\n
0.4:Nieznany parametr: %s\nUßyj /? aby uzyskaç pomoc\n
# misc messages
1.0:Nieznany system operacyjny
1.1:%lu bajt¢w\n
1.2:(%s bajt¢w)\n
1.3: (%7s bajt¢w)\n
# memory types
2.0:Typ pamiëci         Suma      Ußytej     Wolnej\n
#   ----------------  --------   --------   --------
2.1:Konwencjonalna
2.2:Wysoka
2.3:Zarezerwowana
2.4:XMS
2.5:Caíkowita pamiëç
2.6:Caíkowitej ponißej 1 MB
2.7:Caíkowitej EMS
2.8:Wolnej EMS
2.9:Najwiëkszy dopuszczalny program wykonywalny 
2.10:Najwiëkszy wolny blok pamiëci wysokiej
2.11:%s rezyduje w pamiëci wysokiej.\n
# block types
3.0:
3.1:wolna
3.2:kod systemowy
3.3:dane systemowe
3.4:program
3.5:ûrodowisko
3.6:pole danych
3.7:zarezerwowane
3.8:sterownik
3.9:IFS
# classify msgs
4.0:\nModuíy ußywajÜce pamiëci ponißej 1 MB:\n\n
4.1:  Nazwa          Total          Konwencjonalna      Pamiëç wysoka\n
#     --------  ----------------   ----------------   ----------------
4.2:SYSTEM
4.3:Wolna
4.4:\nSegment  Rozmiar    Nazwa         Typ\n
#     ------- --------  ----------  -------------
4.5:\n    Adres     Atryb.   Nazwa      Program\n
#      -----------  ------ ----------  ----------
# EMS stuff
5.0:WEWNêTRZNY BúèD EMS.\n
5.1: Sterownik EMS nie jest zainstalowany w systemie.\n
5.2:\nWersja sterownika EMS
5.3:EMS page frame
5.4:Caíkowita pamiëç EMS
5.5:Wolna pamiëç EMS
5.6:Wszystkich handle
5.7:Wolne handle
5.8:\n  Handle  Strony   Rozmiar     Nazwa\n
#      -------- ------  --------   ----------
# XMS stuff
6.0:Sterownik XMS nie jest zainstalowany w systemie.\n
6.1:\nTestowanie pamiëci XMS...\n
6.2:WEWNêTRZNA PAMIêï XMS.\n
6.3:INT 2F AX=4309 wspierane\n
6.4:wersja XMS
6.5:wersja sterownika XMS
6.6:status HMA
6.7:istnieje
6.8:nie istnieje
6.9:status linii A20
6.10:wíÜczone
6.11:wyíÜczone
6.12:Wolna pamiëç XMS
6.13:Najwiëkszy blok XMS
6.14:Free handles
6.15: Blok    Handle    Rozmiar   Locks\n
#    ------- --------  --------  -------
6.16:Wolna wysoka pamiëç
6.17:Najwiëkszy wysoki blok
6.18:Pamiëç wysoka niedostëpna\n
# help message
7.0:FreeDOS MEM wersja %d.%d\n
7.1:Wyûwietla rozmiar wolnej i ußytej pamiëci w systemie.
7.2:Skíadnia: MEM [/E] [/F] [/C] [/D] [/U] [/X] [/P] [/?]
7.3:/E  Wyûwietla wszystkie informacje o pamiëci EMS
7.4:/F  Przedstawia peínÜ listë blok¢w pamiëci
7.5:/C  Klasyfikuje moduíy korzystajÜce z pamiëci ponißej 1 MB
7.6:/D  Wyûwietla listë sterownik¢w obecnych w pamiëci
7.7:/U  Wyûwietla listë program¢w w pamiëci konwencjonalnej i wysokiej
7.8:/X  Wyûwietla wszystkie informacje o pamiëci XMS
7.9:/P  Zatrzymuje sië po kaßdym peínym ekranie
7.10:/?  Wyûwietla pomoc
8.0:\nNaciûnij <Enter> aby kontynuowaç lub <Esc> aby zako§czyç...
