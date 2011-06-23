
                   XDMA -- DOS UltraDMA Disk Driver, V3.3
                 ==========================================

1. General Description
   -------------------

   XDMA is a DOS driver for UltraDMA hard-disks.   It supports normal "end
   user" PC mainboards having an Intel, VIA, SiS, ALi, or similar UltraDMA
   controller set by the BIOS in "Legacy IDE mode".   XDMA does NOT handle
   Serial-ATA, "Native PCI mode" servers or "add-on" adapter cards made by
   Promise, SiiG, etc.   XDMA runs normal mainboard IDE chips and AVOIDS a
   need for an "add-on" card!

   XDMA handles up to 4 UltraDMA disks of any size, including newer models
   over 128 gigabytes of storage.    It "intercepts" DOS disk I-O requests
   issued as "Int 13h" calls for the BIOS; read/write requests are handled
   using UltraDMA.    All other "Int 13h" calls (seeks, requests for other
   device types, etc.) are "passed" back to the BIOS or to another driver.
   XDMA accepts 48-bit LBA mode I-O requests used by MS-DOS V7.xx, FreeDOS
   or other newer DOS systems that use LBA mode I-O.   24-bit CHS requests
   used by MS-DOS V6.xx or other "old" DOS systems are also accepted.   As
   CHS I-O has only 24-bit addressing, data accessed using CHS I-O must be
   in the first 8 gigabytes of a disk.   Other partitions may contain more
   data and may be accessed by operating systems that permit LBA mode I-O.

   XDMA offers output overlap, which buffers all output and does NOT await
   output end, so user work may overlap the DMA!   Depending on the user's
   system and software, overlap can increase speed significantly!   For an
   output error or 400-msec output timeout, an error message will display,
   and a warning "beep" will sound.   Overlap must be enabled with a /O in
   the CONFIG.SYS command which loads XDMA (see section 3 below for switch
   options).   Output overlap requires that each IDE channel CANNOT run an
   UltraDMA disk and an ATAPI drive (CD-ROM, etc.) or a non-UltraDMA unit!
   Other drivers are unaware XDMA leaves output "running" and such drivers
   may post controller-busy ERRORS if using the same channel as XDMA.   If
   either IDE channel runs an UltraDMA disk and an ATAPI or a non-UltraDMA
   drive, output overlap must NOT be enabled!    XDMA is intended for most
   "home user" systems, which normally place their UltraDMA disk(s) on the
   primary IDE channel, with ATAPI and other units placed on the secondary
   IDE channel.   These systems can achieve better speed IMMEDIATELY using
   XDMA with output overlap!    NOTE that the XCDROM driver DOES permit an
   UltraDMA disk and a CD/DVD drive to "share" an IDE channel and use XDMA
   output overlap!

   XDMA requires 1344 bytes of memory with output overlap enabled and 1056
   bytes without overlap.   An XMS manager, HIMEM.SYS or similar, and 128K
   of XMS memory are also required, so XDMA can allocate a "local buffer".
   For overlap or for any user I-O buffers not meeting UltraDMA alignment/
   boundary rules, UltraDMA I-O goes through the "local buffer" which acts
   as a "middleman" between the user buffer and the disk.   Almost all DOS
   systems do load HIMEM.SYS, since it lets the DOS "kernel" reside in the
   high-memory area (HMA) and saves MUCH space below 640K!


2. Revision History
   ----------------

   V3.3  15-Feb-06  Deleted /B /M /N /S switches.     XDMAJR discontinued
                      (XDMA is now under 2.5K bytes).

   V3.2  31-Jan-06  Deleted init "Set Mode" commands (BIOS does them), to
                      avoid conflicts.   NO run-time changes.

   V3.1  26-Dec-05  Overlap XDMA now named "XDMA1$", so other IDE drivers
                      can use its "OCheck" to check overlap.   Minor XDMA
                      and XDMAJR updates.   NO changes in run-time sizes.

   V3.0  15-Dec-05  XDMA/XDMAJR now set "XDMA_$" names (overlap XDMA sets
                      "XDMA$$") to confirm controller address valid.
   V2.9  14-Dec-05  XDMA output overlap "re-entry" routine corrected.  No
                      change to non-overlap XDMA nor to XDMAJR.
   V2.8  27-Nov-05  XDMA and XDMAJR "Internationalized" and init messages
                      are now a separate file defaulting to XDMAMSGS.ENG.
   V2.7  24-Nov-05  XDMA output-overlap now sets IDE channel busy/overlap
                      flags, so overlap WILL work with other IDE drivers.
   V2.6  17-Nov-05  XDMA/XDMAJR now have a /N switch to request NO local-
                      stack.   XDMA.ASM now assembles BOTH drivers!   DRQ
                      timeout replaced with DMA timeout code.
   V2.5  10-Nov-05  Re-added /B, /S, "DMA only" mode to XDMA.    Re-added
                      /S to XDMAJR.   Except for no XDMA read-tests, XDMA
                      and XDMAJR are now EQUAL to the older UDMA2/UDMA2S!
   V2.4   5-Nov-05  README.TXT file updated with "advisory" RULES for use
                      of UMBPCI.   Minor XDMA and XDMAJR size reductions.
   V2.3   2-Nov-05  XDMA and XDMAJR have better messages, the full set of
                      error codes, and allow different CHS values for all
                      disks.   XDMAJR upgraded with all but overlap.
   V2.2  23-Oct-05  Fixed "NMI" stack-switching error in XDMA and XDMAJR.
   V2.1  21-Oct-05  Fixed XDMA /M error.  No changes to XDMAJR.
   V2.0  15-Oct-05  XDMA made smaller; re-added XDMAJR disk-name display.
   V1.9  10-Oct-05  Fixed XDMAJR "no disks" error.  Other minor changes.
   V1.8   2-Oct-05  Re-added the 80386+ check in XDMA and a hardware-only
                      disk scan in XDMAJR.   Updated EDD BIOS disk scan.
   V1.7  24-Sep-05  Re-added a hardware-only disk scan in XDMA, to handle
                      an IBM ThinkPad or others with a missing/incomplete
                      EDD BIOS (see section 6 below).   XDMAJR unchanged.
   V1.6  15-Sep-05  Changed to NASM source format for both drivers, fixed
                      an LBA-mode error in XDMAJR.
   V1.5  22-Aug-05  Added the smaller/simpler XDMAJR; no changes to XDMA.
   V1.4  18-Aug-05  Fixed ES-reg. saves/reloads and minimized init logic.
   V1.3   3-Aug-05  Added David Muller's EDD BIOS 30-byte "validity test"
                      and ALi controller class-codes.   THANK YOU, David!
   V1.2  30-Jun-05  Eliminated "forward code-modification" errors.
   V1.1  18-Jun-05  Simpler README file; added version number to title.
   V1.0  15-Jun-05  Original XDMA issue.


3. Switch Options
   --------------

   XDMA switch options are as follows:

      /O    Enables output overlap, as described above.

      /L    Limits DMA to "low memory" below 640K.   /L is REQUIRED to use
              UMBPCI or similar drivers whose upper-memory areas cannot do
              DMA.   If /L is given, the driver must be in LOW memory (I-O
              command lists use DMA), or driver loading ABORTS!   /L makes
              the driver use its "local buffer" for I-O of data past 640K.

      /Q    Suppresses the "beep" on output-overlap errors ("quiet" mode).

   For all switches, a dash may replace the slash, and a lower-case letter
   may be used.


4. Setup and Configuration
   -----------------------

   XDMA is loaded with the CONFIG.SYS file, after any upper-memory manager
   such as EMM386.EXE but BEFORE any "disk cache" program such as NCACHE2.
   Your CONFIG.SYS file must have a command line similar to:

            DEVICE[HIGH] = [path]XDMA.SYS [/O] [/L] [/Q]

   Examples:    DEVICE=C:\DOS\XDMA.SYS
                DEVICEHIGH=C:\BIN\XDMA.SYS /O

   Please be sure to set each hard disk's geometry correctly in your BIOS.
   Set it to "Auto", "LBA" or "LBA Assisted", but NOT to "None", "Normal",
   "CHS", "ECHS".   "User Cylinders/Heads/Sectors", "Revised ECHS" or "Bit
   Shift" should run but are NOT preferred.   If a BIOS has a setting like
   "UDMA Capable" for a disk, enable it.   Power-saving features such as a
   "drive spin-down timeout" should be DISABLED or driver I-O requests may
   time out!   Also, be sure to use an 80-connector cable for any UltraDMA
   disk operating in "mode 3" ATA-44 (44 MB/sec) or higher.   When cabling
   a single disk to an IDE channel,  note that you MUST use both "ends" of
   the cable, NOT one "end" and the middle connector!   This avoids ERRORS
   as an unused cable-end CAN pick up "noise", like a RADIO antenna!


5. Error Reporting
   ---------------

   On exit from a successful I-O request, the AH-register is zero, and the
   carry flag is reset.   When an I-O error occurs, the carry flag is SET,
   and the AH-register contains an error return code, as follows:

          Code 08h - DMA timed out.
               0Fh - DMA error.
               20h - Controller busy before I-O.
               21h - Controller busy after I-O.
               AAh - Disk not ready before I-O.
               ABh - Disk not ready after I-O.
               CCh - Disk FAULT before I-O.
               CDh - Disk FAULT after I-O.
               E0h - Hard error at I-O end.
               FFh - XMS memory error.

   When XDMA output overlap is enabled, a run-time output error will cause
   the following message to be displayed, along with a short "beep" sound:

          XDMA Error eeh, Disk=d LBA=aaaaaaaaaaaah!

   where eeh is one of the return codes listed above, d is the disk number
   (0 for primary-master, 1 if primary-slave, 2 if secondary-master, and 3
   for secondary-slave), and aaaaaaaaaaaah is the starting disk address of
   the output request, shown as a 12-digit "logical block address".   XDMA
   handles only BIOS Int 13h calls (not DOS "file I-O"), so it is NOT told
   and cannot display the DOS file/directory for an output overlap error.


6. SPECIAL NOTES
   -------------

   The UMBPCI upper-memory driver (or similar) "creates" upper-memory from
   system "shadow RAM" which CANNOT do UltraDMA!   Newer BIOS programs may
   use UltraDMA when loading programs in upper-memory.   If this is UMBPCI
   "shadow RAM", a CRASH will result!   To avoid this and support new BIOS
   programs, using UMBPCI and XDMA together requires the following RULES:
     A) XDMA must be loaded BEFORE the UMBPCI driver so XDMA can take-over
          UltraDMA disk I-O from the BIOS.
     B) XDMA must load with the /L switch, so it limits UltraDMA to memory
          below 640K and avoids accessing "shadow RAM".
     C) If CHS I-O is used, all disks must have valid CHS parameters so no
          I-O need be "passed" to the BIOS (may cause the same CRASH!!).
   Except as noted above for the /L switch, these rules are "advisory" and
   NOT enforced by driver logic.   They are the USER'S responsibility when
   UMBPCI will be run with XDMA!

   The EDD BIOS of some "notebooks" (IBM ThinkPad, etc.) or mainboards may
   NOT offer the "DPTE" data needed in scanning for UltraDMA disks to use!
   Starting in V1.7 XDMA, if an EDD BIOS is missing or incomplete, or when
   no UltraDMA disks are found using the EDD BIOS, a hardware-only scan is
   then done.    In this case, XDMA assumes that the BIOS assigned DEFAULT
   "unit numbers" to each UltraDMA disk, as follows:
       A) Primary-master   disk must be BIOS "unit 80h".
       B) Primary-slave    disk (if present) must be BIOS "unit 81h".
       C) Secondary-master disk (if present) must be BIOS "unit 82h".
       D) Secondary-slave  disk (if present) must be BIOS "unit 83h".
   The default BIOS assignments occur ONLY if the UltraDMA disks have been
   "cabled" to the system in the above order, i.e., the first disk MUST be
   primary-master, second must be primary-slave etc.   Other IDE units may
   use the remaining IDE positions or another controller, so the BIOS sees
   all UltraDMA disks FIRST!   If SCSI disks are present, their controller
   BIOS (if any) must be DISABLED, so SCSI disks do not receive BIOS "unit
   numbers", and an IDE disk must "boot" such systems.    The controller's
   DOS driver can be used after "boot" to access SCSI disks.     Note that
   if a complete EDD BIOS is present and a hardware-only scan is unneeded,
   SCSI and IDE disks may be cabled to the system in ANY order, and a SCSI
   controller's BIOS can be enabled.

   Some CD-ROM "boot" programs handle the CD-ROM as a "fake" hard disk and
   provide incorrect EDD BIOS data for it!   In scanning for disks to use,
   XDMA may display "EDD BIOS error!  Unit ignored." and go on looking for
   more UltraDMA disks.   Users who did NOT "boot" from CD-ROM need to see
   what disk was passed-over and why.   Users who DO "boot" from a CD-ROM,
   where all UltraDMA disks were found correctly, may IGNORE this message!
   It is caused by an ERROR in the CD-ROM "boot" program, NOT by a problem
   with XDMA or its hard-disks!

   Some BIOS programs may NOT "configure" the mainboard UltraDMA chip when
   no IDE devices are found!    If no UltraDMA disks are found, the driver
   usually displays "No disk to use" and abort loading.   But it looks for
   controller chips to use first, and an "unconfigured" chip may give "BAD
   UltraDMA controller", then an abort.    If the latter message displays,
   users must first verify that every UltraDMA hard-disk was made "active"
   through the BIOS set-up routines.    If this WAS done, "BAD controller"
   means the UltraDMA chip was NOT given both "Bus Master" and "I-O Space"
   command bits, and the BIOS needs to be UPDATED!
