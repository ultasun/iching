      PROGRAM ICHING(INPUT,OUTPUT,PUNCH)
C        GENERATION AND QUANTIFICATION OF AN ≠I CHING≠ MODULAR HIERARCHY
C
C        ORIGINATOR - TERENCE MCKENNA
C        PROGRAMMER - LEON TAYLOR
C        DATE - FEBRUARY, 1974
      INTEGER HEX(6,65),WAVE(64),REVWAV(64),ANGLE1(64),ANGLE2(64),
     1 QUANWV(64),ANCOQU(384,4),A(384,4),DICOQU(384,4),D(384,4)
      INTEGER LINSCL(384),TRISCL(384),HEXSCL(384),DIST( 64),TOTAL(384)
      INTEGER AVG(6),FRMEAN,GRMEAN,VALUE(384)
      INTEGER DIFF(384),PREVAL(7)
      INTEGER MODE(3),IHRFR(3),IHRSRT(3),IHRSTP(3),AA(6,65),AB(6,65)
     1 ,IAA(64),IAB(64),IHXVAL(64),IAAM(64),IABM(64)
      INTEGER IPOSA(64),IPOSB(64),RVWVA(64),RVWVB(64)
      INTEGER SMALL,LARGE,POSITS,POSITL
      EQUIVALENCE (A,VALUE)
      EQUIVALENCE (ANCOQU,A) ,(DICOQU,D)
C        READ IN 384 YAO(LINES) TO FORM 64 HEXAGEAMS.
      DO 5 I=1,64
    5 READ 1,((HEX(J,I),J=1,6))
    1 FORMAT(6(I1,1X))
C        SET-UP 65TH POSITION FOR WRAP-AROUND (LATER USE).
      DO 8 I=1,6
    8 HEX(I,65) = HEX(I,1)
C
      READ 3,NFRAME,ISTART,ISTOP
3     FORMAT(3I3)
C        *************************
      CALL WAVEC(HEX,WAVE)
C
C
C
C        FORM THE REVERSE SIMPLE WAVE,IE. WAVE(1)=REVWAV(63), WHERE
C        THE SUM ALWAYS =64, EXCEPT THAT WAVE(64)=REVWAV(64).
C
      DO 20 I=1,63
   20 REVWAV(64-I) = WAVE(I)
      REVWAV(64) = WAVE(64)
C
C
C        EVALUATE ANGLES AND SKEW OF LEFT SIDE OF WAVE(WAVE)
C         WAVE(64)-WAVE(1)=3-6=-3,WAVE(1)-WAVE(2)=6-2=4,
C         WAVE( 2)-WAVE(3)=2-4=-2,WAVE(3)-WAVE(4)=4-4=0.
      ANGLE1(1) = WAVE(64) - WAVE(1)
C        CHANGE SIGNS OF POSITIONS 33 THRU 64, SO THEY HAVE A CANCELLING
      DO 30 I=2,32
   30 ANGLE1(I) = WAVE(I-1) - WAVE(I)
      DO 32 I=33,63
   32 ANGLE1(I) = -(WAVE(I-1) - WAVE(I))
C
C        SPECIAL CONDITIONS OF WAVES DUE TO CROSS-OVER POINTS.
C
      ANGLE1(32) = 0
      ANGLE1(64) = 0
C
C        NOW EVALUATE ANGLES AND SKEW FOR RIGHT SIDE (REVERSE WAVE).
      DO 35 I=2,33
   35 ANGLE2(65-I) = REVWAV( I-1) - REVWAV(I)
C
C        SPECIAL CONDITIONS OF WAVES DUE TO CROSS-OVER POINTS.
C
      ANGLE2(32) = 0
      ANGLE2(64) = 0
C        CHANGE SIGNS OF POSITIONS 33 THRU 64, SO THEY HAVE A CANCELLING
      DO 36 I=34,64
   36 ANGLE2(65-I)=-(REVWAV( I-1) - REVWAV(I))
C        AGAIN CORRECT FOR SIGN VALUES.
      DO 38 I=1,63
      ANGLE1(I) = -ANGLE1(I)
   38 ANGLE2(I) = -ANGLE2(I)
C        FORM DISTANCES.      WAVE SCALE IS 1-6, REVWAVE SCALE 6- 1,
C        WITH AN OVERLAP OF 3. THEREFORE 9-REVWAV WITH A VALUE OF 2=7
C        ON PLOTTED SCALE AND REVWAV VALUE 1=8 ON SAME SCALE.
C        SPECIAL CASE
      DIST(1) = (9 - REVWAV(63)) - WAVE(64)
      DIST(64) = (9 - REVWAV(64)) - WAVE(63)
C        REVWAV 62-2 ON PRINTOUT IS REALLY STORED AS 2-62.
      DO 200 I=2,63
      DIST(I) = (9 - REVWAV(   I)) - WAVE(I-1)
  200 CONTINUE
C
C        FORM ANGLES QUANTIFIED FROM SIMPLE WAVE (ANGLE1 + ANGLE2).
C
C        SUBSCRIPT OF ANGLE1 + ANGLE2 M U S T  = 0, EXCEPT FOR 64 TH
C        POSITION.
      DO 45 I=1,63
   45 QUANWV(I) = ANGLE1(I) + ANGLE2(64-I)
      QUANWV(64) = 0
C
C
C
C        FORM ANCOQU(384,4), WHWRE COL. 1=ANGLE, COL. 2=COMPONENT, AND
C         COL. 3=QUANTIFICATION.
C
C        FORM DICOQU(384,4), WHERE COL.1 = DIST AND REMAINDER IS LIKE
C        ANCOQU.
C
C        SET-UP COL. 1 BY REPEATING QUANWV 6 TIMES FOR 384 CASES.
C
      ICOUNT = -65
      DO 50 J=1,6
      ICOUNT = ICOUNT + 64
      DO 50 I=2,64
      IJ = I + ICOUNT
      LINSCL(II) = I
      DICOQU(II,1) = DIST(I)
   50 ANCOQU(II,1) = QUANWV(I)
      DO 55 L=64,320,64
      LINSCL(L) = 1
      TRISCL(L) = 1
      DICOQU(L,1) = DIST(1)
   55 ANCOQU(L,1) = QUANWV(1)
C
C        SET-UOP  COL. 2 BY REPEATING EACH QUANWV ELEMENT 3 TIMES FOR AL
C         64 POSITIONS AND REPEAT PROCESS TWICE FOR 384 CASES.
C
      II = 0
      DO 65 J=1,2
      DO 60 I=2,64
      DO 60 K=1,3
      II = II + 1
      TRISCL(II) = I
C        MULTIPLY TRIGRAMMATIC  BY 3 SINCE 3 TIMES GREATER THAN THE
C        LINEAR SCALE.
      DICOQU(II,2) = DIST(I) * 3
  60  ANCOQU(II,2) = QUANWV(I ) * 3
      DO 62 L=190,192
      TRISCL(L) = 1
      DICOQU(L,2) = DIST(1) * 3
   62 ANCOQU(L,2) = QUANWV(1) * 3
   65 II = 192
C        FILL IN LAST 3 POS. OF 192 WITH 1≠S.
C
C        SET-UP COL. 3 BY REPEATING EACH ELEMENT OF QUANWV 6 TIMES
C         FOR ALL 64 POSITIONS GIVING 384 CASES.
C
      II = 0
      DO 75 I=2,64
      DO 70 K=1,6
      II = II + 1
      HEXSCL(II) = I
C        MULTIPLY HEXAGRAMMATIC BY 6 SINCE 6 TIMES GREATER THAN THE
C        LINEAR SCALE.
      DICOQU(II,3) = DIST(I) * 6
   70 ANCOQU(II,3) = QUANWV(I)  * 6
   75 CONTINUE
C
C
C        STARTING POINT FOR ALL SCALES IS  2  2   2 , THEREFORE
C        WE NEED TO REALIGN AND FILL IN POSITIONS 384, 382, 379 FOR
C        LINSCL, TPISCL, AND HEXSCL RESPECTIVELY WITH 1≠S.
      LINSCL(384) = 1
      DICOQU(384,1) = DIST(1)
      ANCOQU(384,1) = QUANWV(1)
C
      TRISCL(382) = 1
      TRISCL(383) = 1
      TRISCL(384) = 1
      DICOQU(382,2) = DIST(1) * 3
      DICOQU(383,2) = DIST(1) * 3
      DICOQU(384,2) = DIST(1) * 3
      ANCOQU(382,2) = QUANWV(1) * 3
      ANCOQU(383,2) = QUANWV(1) * 3
      ANCOQU(384,2) = QUANWV(1) * 3
C
      DO 77 K=379,384
      HEXSCL(K ) = 1
      DICOQU(K,3) = DIST(1) * 6
   77 ANCOQU(K ,3) = QUANWV(1) * 6
C
C
C        NOW ESTABLISH 4TH COL. BY SUMMING 1ST THREE COLS.
C
      DO 80 I=1,384
      DICOQU(I,4) = D(I,1) + D(I,2) + D(I,3)
   80    ANCOQU(I,4) = ANCOQU(I,1) + ANCOQU(I,2) + ANCOQU(I,3)
C
C        FORM TOTAL BY THE SUM OF ≠ANGLE AND DIST≠.  ABSOLUTE VALUES.
      DO 100 I=1,384
  100 TOTAL(I) =IABS(A(I,4)) + IABS(D(I,4))
C
C
C        FORM FIRST ORDER DIFFERENCES.
      DIFF(1) = TOTAL(1)
C
      DO 104 I=2,384
  104 DIFF(I) = TOTAL(I) - TOTAL(I-1)
C
C
C
C
C        FOR FRAME NUMBER1 START WITH POS 380 AND END WITH 1
C        (6 POSITIONS.  ENDING POSITION GIVES FRAME NUMBER AND
C        WRAPAROUND (384 TO 1) BASIC FORMULA FOR EACH FRAME IS
C        AS FOLLOWS VALUE= RELATIVE POSITION (ALWAYS 384 TO 1) +
C        (ISTART VALUE (POSITION) ≠ MULTIPLIER WHERE MULTIPLIER
C        GOES FROM 1 TO 64 ,ASCENDING) IF POSIT FOR EXAMPLE IS
C        379 TO 380 = VALUE OF FOUR TO 7 IF POSIT FOR EXAMPLE IS
C        380 TO381 = VALUE OF 7 TO2 IS DESCENDING AND THEREFORE
C        MULTIPLIER GOES FROM 64 TO 1.  ON THE OTHER HAND IF
C        THERE IS NO CHANGE IN VALUE OF POSIT THEN MUST GO BY
C        PREVIOUS MULTIPLIER EITHER ASCENDING OR DESCENDING
C        FOR EXAMPLE POSIT 382 TO 383 = VALUE OF 0 TO 0 BUT
C        POSIT 381 TO 382 = VALUE OF 2 TO 0 IS DESCENDING 
C        THEREFORE MULTIPLIER IS 1  THERE ARE SOME CASES WHEN BOTH
C        ARE THE SAME BUT PREVIOUS VALUES WERE ASCENDING
C        THEREFORE USE 64 AS A MULTIPLIER  FOR EACH OF THE ABOVE
C        CASES≠USE≠ POSIT (ISTART VALUE) 64 TIMES WITH EACH
C        OF THE MULTIPLIERX BEFORE MOVING ON TO THE NEXT POSIT
C        VALUE  THIS MEANS FOR EACH FRAME (384 VALUES) WE NEED
C        6 POSIT VALUES FOR ISTART.
      MUL = 1
      GRMEAN = 0
      DO 1000 L =1,NFRAME
      ISTART = ISTART + 1
      ISTOP = ISTOP + 1
      IF (ISTART .EQ. 385) GO TO 350
C        HERE IF NEED TO START AT POSIT. 1, ELSE BYPASS INITIAL COND.
      GO TO 400
  350 ISTART = 1
      ISTOP = 6
C
C        FRAME MEAN = 0
  400 FRMEAN = 0
      IPRES = ISTART
C        ISTOPP KEEPS TRACK OF THE 6 POSITIONAL VALUES  FOR EACH FRAME.
      ISTOPP = ISTOP - 1
C        II = RELATIVE POSIT. IN EACH FRAME (1-384)
      II = 0
C
C        FILL IN VALUES FOR EACH ELEMENT IN THIS FRAME.C
C
      DO 500 I=1,6
C
C        RULE 1. THE VALUE MULTIPLED 64 TIMES IN EACH 1/6 OF A FRAME
C        IS NOT THE QUANTIFIED ≠VALUE≠, BUT INSTEAD IS THE DIFFERENCE
C           BETWEEN THE QUANTIFIED  VALUE AND THE PRECEEDING VALUE.
C
C        RULE 2. IF A SERIES OF 64 NUMBERS IS TO BE ASCEND OR REMAIN
C        THE SAME ,THEN EACH OF THE 64 NUMBERS MUST BE ADDED TO THE
C        LAST NUMBER IN THE PREVIOUS SET OF 64.
C          IF A SERIES OF 64 NUMBERS IS TO        DESCEND, THEN EACH
C          OF THE 64 NUMBERS MUST BE SUBTRACTED FROM THE LAST NUMBER
C          IN THE PRECEEDING SET OF 64.
C
C        FOR FRAME ≠N≠, TAKE THE 384TH POSITION OF FRAME ≠N≠ - 6 * 64
C        PLUS (IF ASCENDING) OR MINUS (IF DESCENDING), TO THE 1ST 
C        ORDER OF DIFFERENCE, WHERE NN=1,64 + THE QUANTIFUED POSITION
C        SUM. THE VALUE FRAME ≠N≠ - 6 CHANGES EVERY 64 TIMES,
C        NOT EVERY 384.
C
C        RESTORE BACK TO ORIGINAL FRAME NUMBER.
      ISTOPP = ISTOPP + 1
      IF (ISTOPP .LE. 6) GO TO 403
      IVAL = ISTOPP - 6
      GO TO 404
  403 IVAL = 378 +ISTOPP
  404 PREVAL(I) = TOTAL(IVAL) * 64
C        1ST DETER. MULTIPLIER
      IF (IPRES .EQ. 385) GO TO 405
C        IF ISTART=1, PICK UP PREVIOUS VALUE, NEED POSIT. 384.
      IPREV = IPRES  - 1
      IF (IPREV .EQ. 0 ) IPREV = 384
      GO TO 408
  405 IPREV = 384
      IPRES = 1
  408 IF (TOTAL(IPREV) - TOTAL(IPRES) ) 410,450,430
C        HERE, IF - MEANS ASCENDING ORDER OF MULT.
  410 DO 415 K=1,64
      II = II + 1
  415 VALUE(II) = PREVAL(I) + TOTAL(II) + (DIFF(IPRES) * K)
C        UP  IPRES BY 1 FOR EACH OF 6 CASES WITHIN 1 FRAME.
C        NEGPOS = 1 IS ASCENDING SWITCH.
      NEGPOS = 1
      GO TO 470
C        HERE IF +, MEANS DESCENDING ORDER OF MULT.
  430 DO 435 K=1,64
      II = II + 1
  435 VALUE(II) = PREVAL(I) + TOTAL(II) + (DIFF(IPRES) * K)
      NEGPOS = 2
      GO TO 470
C        HERE IF =. 1ST DETERMINE IF PREVIOUS CONDITION WAS
C        ASCENDING OR DESCENDING.
  450 GO TO (452,454),NEGPOS
C        ASCENDING  MULT . IS ALWAYS 64 FOR 64 CASES.
  452 MULT = 64
      NEGPOS = 1
      DO 453 K=1,64
      II = II + 1
  453 VALUE(II) = PREVAL(I) + TOTAL(II) + (DIFF(IPRES) * MULT)
      GO TO 470
C
C        DESCENDING, MULT. IS ALWAYS 1 FOR 64 CASES.
  454 MULT = 1
      NEGPOS = 2
      DO 460 K=1,64
      II = II + 1
  460 VALUE(II) = PREVAL(I) + TOTAL(II) + (DIFF(IPRES) * MULT)
C        HERE WHEN FILLING IN 64 VALUES. NEED TO GET NEXT 64 UNTIL 384.
C
  470 IPRES = IPRES + 1
  500 CONTINUE
C
C
C        DO AVERAGES FOR EACH 64 VALUES.
      II = 0
      DO 504 I=1,6
      AVG(I) = 0
      DO 502 K=1,64
      II = II + 1
  502 AVG(I) = AVG(I) + VALUE(II)
      AMEAN = AVG(I)
      AVG(I) = AMEAN/64. + 0.5
      FRMEAN = FRMEAN + AVG(I)
  504 CONTINUE
C        
C        FIND THE LOWEST VALUE AND ITS POSITION, LIKEWISE FOR THE
C        HIGHEST VALUE AND ITS POSITION, THEN PRINT AFTER EACH FRAME.
      SMALL = VALUE(J)
      POSITS = 1
      DO 5040 J=2,384
      IF (SMALL.LT. VALUE(J)) GO TO 5040
      SMALL = VALUE(J)
      POSITS = J
 5040 CONTINUE
      LARGE = VALUE(J)
      POSITL = 1
      DO 5050 J=2,384
      IF (LARGE.GT. VALUE(J)) GO TO 5050
      LARGE = VALUE(J)
      POSITL = J
 5050 CONTINUE
C
C
      FRMEAN = FRMEAN / 6
      GRMEAN = GRMEAN + FRMEAN
C        IF MULTIPLE OF 6 PRINT
      IF((ISTOP/6*ISTOP - ISTOP*MUL ) .NE. 0) GO TO 1000
      MUL   = MUL  + 1
      PRINT 510,ISTOP
  510 FORMAT(1H1//// 30X,33HEVALUATION OF HIERARCHICAL FRAMES,1X//40X,
     1  6HFRAMF ,I3///1X,12(3HPJS,1X,5HVALU ,1X)/)
      DO 550 J=1,32
      J32 = J+32
      J64=J+64
      J96 = J+96
      J128=J+128
      J160=J+160
      J192=J+192
      J224=J+224
      J256=J+256
      J288=J+288
      J320=J+320
      J352=J+352
  550 PRINT 525,J,VALUE(J),J32,VALUE(J32),J64,VALUE(J64),J96,VALUE(J96),
     1 J128,VALUE(J128),J160,VALUE(J160),J192,VALUE(J192),
     2 J224,VALUE(J224),J256,VALUE(J256),J288,VALUE(J288),
     3 J320,VALUE(J320),J352,VALUE(J352)
  525 FORMAT(1X,12(I3,1X,15,1X))
      PRINT 530,(AVG(J),J=1,6),FPMEAN ,SMALL,POSITS,LARGE,POSITL
  530 FORMAT(//1X,13HMEAN FOR EACH/1X,12H64 POSITIONS,1X,I5,1X,5(13X,
     1 I5,1X)//20X,23HMEAN FOR 384 POSITIONS=,I5//
     2 20X, 15HLOWEST VALUE = ,I5,2X,19HAND ITS POSITION = ,I3//
     3 19X,16HHIGHEST VALUE = ,15,2X,19HAND ITS POSITION = ,I3)
C
C
      IF (L .NE. NFRAME) GO TO 1000
      GPMEAN = GRMEAN / NFRAME
      PRINT 540, GRMEAN
  540 FORMAT(//20X,33HGRAND MEAN FOR ALL 384 FRAMES IS ,I4)
 1000 CONTINUE
C
C
      CALL EXIT
      END