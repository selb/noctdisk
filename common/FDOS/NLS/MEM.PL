#Translated by Mateusz Viste "Fox" / the.killer@wp.pl
#Polish letters encoded in the MAZOVIA standard
#Homepage: http://www.the.killer.webpark.pl/en/fdos_pl.htm
#
# fatal errors
0.0:Brak pami�ci. Brakuje %ld bajt�w.\n
0.1:SYSTEM MEMORY TRASHED! (int 21.5803 failure)\n
0.2:UMB Corruption: Chain doesn't reach top of low RAM at %dk. Last=0x%x.\n
0.3:The MCB chain is corrupted (no Z MCB after last M MCB, but %c at seg 0x%x).\n
0.4:Nieznany parametr: %s\nU�yj /? aby uzyska� pomoc\n
# misc messages
1.0:Nieznany system operacyjny
1.1:%lu bajt�w\n
1.2:(%s bajt�w)\n
1.3: (%7s bajt�w)\n
# memory types
2.0:Typ pami�ci         Suma      U�ytej     Wolnej\n
#   ----------------  --------   --------   --------
2.1:Konwencjonalna
2.2:Wysoka
2.3:Zarezerwowana
2.4:XMS
2.5:Ca�kowita pami��
2.6:Ca�kowitej poni�ej 1 MB
2.7:Ca�kowitej EMS
2.8:Wolnej EMS
2.9:Najwi�kszy dopuszczalny program wykonywalny 
2.10:Najwi�kszy wolny blok pami�ci wysokiej
2.11:%s rezyduje w pami�ci wysokiej.\n
# block types
3.0:
3.1:wolna
3.2:kod systemowy
3.3:dane systemowe
3.4:program
3.5:�rodowisko
3.6:pole danych
3.7:zarezerwowane
3.8:sterownik
3.9:IFS
# classify msgs
4.0:\nModu�y u�ywaj�ce pami�ci poni�ej 1 MB:\n\n
4.1:  Nazwa          Total          Konwencjonalna      Pami�� wysoka\n
#     --------  ----------------   ----------------   ----------------
4.2:SYSTEM
4.3:Wolna
4.4:\nSegment  Rozmiar    Nazwa         Typ\n
#     ------- --------  ----------  -------------
4.5:\n    Adres     Atryb.   Nazwa      Program\n
#      -----------  ------ ----------  ----------
# EMS stuff
5.0:WEWN�TRZNY B��D EMS.\n
5.1: Sterownik EMS nie jest zainstalowany w systemie.\n
5.2:\nWersja sterownika EMS
5.3:EMS page frame
5.4:Ca�kowita pami�� EMS
5.5:Wolna pami�� EMS
5.6:Wszystkich handle
5.7:Wolne handle
5.8:\n  Handle  Strony   Rozmiar     Nazwa\n
#      -------- ------  --------   ----------
# XMS stuff
6.0:Sterownik XMS nie jest zainstalowany w systemie.\n
6.1:\nTestowanie pami�ci XMS...\n
6.2:WEWN�TRZNA PAMI�� XMS.\n
6.3:INT 2F AX=4309 wspierane\n
6.4:wersja XMS
6.5:wersja sterownika XMS
6.6:status HMA
6.7:istnieje
6.8:nie istnieje
6.9:status linii A20
6.10:w��czone
6.11:wy��czone
6.12:Wolna pami�� XMS
6.13:Najwi�kszy blok XMS
6.14:Free handles
6.15: Blok    Handle    Rozmiar   Locks\n
#    ------- --------  --------  -------
6.16:Wolna wysoka pami��
6.17:Najwi�kszy wysoki blok
6.18:Pami�� wysoka niedost�pna\n
# help message
7.0:FreeDOS MEM wersja %d.%d\n
7.1:Wy�wietla rozmiar wolnej i u�ytej pami�ci w systemie.
7.2:Sk�adnia: MEM [/E] [/F] [/C] [/D] [/U] [/X] [/P] [/?]
7.3:/E  Wy�wietla wszystkie informacje o pami�ci EMS
7.4:/F  Przedstawia pe�n� list� blok�w pami�ci
7.5:/C  Klasyfikuje modu�y korzystaj�ce z pami�ci poni�ej 1 MB
7.6:/D  Wy�wietla list� sterownik�w obecnych w pami�ci
7.7:/U  Wy�wietla list� program�w w pami�ci konwencjonalnej i wysokiej
7.8:/X  Wy�wietla wszystkie informacje o pami�ci XMS
7.9:/P  Zatrzymuje si� po ka�dym pe�nym ekranie
7.10:/?  Wy�wietla pomoc
8.0:\nNaci�nij <Enter> aby kontynuowa� lub <Esc> aby zako�czy�...
