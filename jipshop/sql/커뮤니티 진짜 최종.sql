
SET DEFINE OFF;

-- ============================================
-- 커뮤니티 샘플 데이터 초기화 + 재생성
-- 기준 스키마: 업로드한 최종 SQL 기준
-- BOARD_TYPE: 1=우리아이 자랑, 2=육아 꿀팁, 3=자유 게시판
-- BOARD_CATEGORY: 101/102/103, 201/202/203
-- 자랑 게시판은 CATEGORY_CODE = NULL
-- 회원번호 1~20 순환 사용
-- 게시판별 30개씩 = 총 90개
-- 이미지/좋아요/댓글/댓글신고 포함
-- 최신 신고댓글 10개 = 미처리(N), 이전 10개 = 처리(Y)
-- ============================================

-- 안전 삭제
BEGIN
    DELETE FROM COMMENT_REPORT
     WHERE COMMENT_ID IN (
        SELECT BC.COMMENT_ID
          FROM BOARD_COMMENT BC
          JOIN BOARD B ON B.BOARD_NO = BC.BOARD_NO
         WHERE B.BOARD_CODE IN (1,2,3)
     );

    DELETE FROM BOARD_LIKE
     WHERE BOARD_NO IN (
        SELECT BOARD_NO FROM BOARD WHERE BOARD_CODE IN (1,2,3)
     );

    DELETE FROM BOARD_IMG
     WHERE BOARD_NO IN (
        SELECT BOARD_NO FROM BOARD WHERE BOARD_CODE IN (1,2,3)
     );

    DELETE FROM BOARD_COMMENT
     WHERE BOARD_NO IN (
        SELECT BOARD_NO FROM BOARD WHERE BOARD_CODE IN (1,2,3)
     );

    DELETE FROM BOARD
     WHERE BOARD_CODE IN (1,2,3);

    COMMIT;
END;
/
SHOW ERRORS;

-- 신고유형 보정
MERGE INTO REPORT_TYPE T
USING (SELECT 1 AS REPORT_TYPE_ID, '욕설' AS TYPE_NAME, 'Y' AS USE_YN FROM DUAL) S
   ON (T.REPORT_TYPE_ID = S.REPORT_TYPE_ID)
WHEN MATCHED THEN
    UPDATE SET T.TYPE_NAME = S.TYPE_NAME, T.USE_YN = S.USE_YN
WHEN NOT MATCHED THEN
    INSERT (REPORT_TYPE_ID, TYPE_NAME, USE_YN)
    VALUES (S.REPORT_TYPE_ID, S.TYPE_NAME, S.USE_YN);

MERGE INTO REPORT_TYPE T
USING (SELECT 2 AS REPORT_TYPE_ID, '광고' AS TYPE_NAME, 'Y' AS USE_YN FROM DUAL) S
   ON (T.REPORT_TYPE_ID = S.REPORT_TYPE_ID)
WHEN MATCHED THEN
    UPDATE SET T.TYPE_NAME = S.TYPE_NAME, T.USE_YN = S.USE_YN
WHEN NOT MATCHED THEN
    INSERT (REPORT_TYPE_ID, TYPE_NAME, USE_YN)
    VALUES (S.REPORT_TYPE_ID, S.TYPE_NAME, S.USE_YN);

MERGE INTO REPORT_TYPE T
USING (SELECT 3 AS REPORT_TYPE_ID, '기타' AS TYPE_NAME, 'Y' AS USE_YN FROM DUAL) S
   ON (T.REPORT_TYPE_ID = S.REPORT_TYPE_ID)
WHEN MATCHED THEN
    UPDATE SET T.TYPE_NAME = S.TYPE_NAME, T.USE_YN = S.USE_YN
WHEN NOT MATCHED THEN
    INSERT (REPORT_TYPE_ID, TYPE_NAME, USE_YN)
    VALUES (S.REPORT_TYPE_ID, S.TYPE_NAME, S.USE_YN);

COMMIT;

DECLARE
    V_BOARD_NO       NUMBER;
    V_COMMENT_ID     NUMBER;
    V_AUTHOR_NO      NUMBER;
    V_COMMENTER_NO   NUMBER;
    V_CATEGORY_CODE  NUMBER;
    V_TITLE          VARCHAR2(200);
    V_CONTENT        VARCHAR2(4000);
    V_READ_COUNT     NUMBER;
    V_CREATE_DATE    DATE;
    V_IMG_FILE       VARCHAR2(200);
    V_ORIGIN_NAME    VARCHAR2(200);
    V_FILE_PATH      VARCHAR2(500) := '/resources/uploadFiles/';
    V_LIKE_CNT       NUMBER;
    V_COMMENT_CNT    NUMBER;
    V_LIKE_MEMBER    NUMBER;

    FUNCTION GET_TIP_CATEGORY(P_IDX NUMBER) RETURN NUMBER IS
    BEGIN
        RETURN CASE MOD(P_IDX-1, 3)
                 WHEN 0 THEN 101
                 WHEN 1 THEN 102
                 ELSE 103
               END;
    END;

    FUNCTION GET_FREE_CATEGORY(P_IDX NUMBER) RETURN NUMBER IS
    BEGIN
        RETURN CASE MOD(P_IDX-1, 3)
                 WHEN 0 THEN 201
                 WHEN 1 THEN 202
                 ELSE 203
               END;
    END;

BEGIN
    -- 회원 1~20 존재 여부 확인
    DECLARE
        V_CNT NUMBER;
    BEGIN
        SELECT COUNT(*)
          INTO V_CNT
          FROM MEMBER
         WHERE MEMBER_NO BETWEEN 1 AND 20;

        IF V_CNT < 20 THEN
            RAISE_APPLICATION_ERROR(-20001, 'MEMBER_NO 1~20 이 MEMBER 테이블에 모두 있어야 합니다.');
        END IF;
    END;

    -- =========================
    -- 1. 우리아이 자랑 30개
    -- =========================
    FOR I IN 1..30 LOOP
        V_AUTHOR_NO := MOD(I-1, 20) + 1;
        V_CATEGORY_CODE := NULL;
        V_READ_COUNT := 10 + (I * 7);
        V_CREATE_DATE := SYSDATE - (35 - I) + (I / 100);

        V_TITLE :=
            CASE MOD(I-1, 6)
                WHEN 0 THEN '우리 아이 산책 인증 ' || I
                WHEN 1 THEN '오늘은 간식 먹는 날 ' || I
                WHEN 2 THEN '잠자는 모습 자랑 ' || I
                WHEN 3 THEN '미용하고 온 기념샷 ' || I
                WHEN 4 THEN '집에서 장난감 놀이 ' || I
                ELSE '귀여움 폭발 사진첩 ' || I
            END;

        V_CONTENT :=
            '우리아이 자랑 게시판 샘플 글 ' || I || '번입니다. ' ||
            '회원번호 ' || V_AUTHOR_NO || '번이 작성한 글이고, ' ||
            '산책, 간식, 낮잠, 미용, 놀이 같은 일상 기록을 담았습니다. ' ||
            '게시글마다 제목/내용/작성일/조회수가 다르게 들어가도록 구성했습니다.';

        INSERT INTO BOARD
        (
            BOARD_NO, MEMBER_NO, BOARD_CODE, CATEGORY_CODE,
            BOARD_TITLE, BOARD_CONTENT, READ_COUNT, CREATE_DATE, BOARD_ACTIVE
        )
        VALUES
        (
            SEQ_BOARD_NO.NEXTVAL, V_AUTHOR_NO, 1, V_CATEGORY_CODE,
            V_TITLE, V_CONTENT, V_READ_COUNT, V_CREATE_DATE, 'Y'
        );

        V_BOARD_NO := SEQ_BOARD_NO.CURRVAL;

        -- 이미지: 자랑 게시판은 20개 정도 넣기
        IF I <= 20 THEN
            V_IMG_FILE :=
                CASE I
                    WHEN 1 THEN 'KakaoTalk_20260322_175758277.jpg'
                    WHEN 2 THEN 'KakaoTalk_20260322_175758277_01.jpg'
                    WHEN 3 THEN 'KakaoTalk_20260322_175758277_02.jpg'
                    WHEN 4 THEN 'KakaoTalk_20260322_175758277_03.jpg'
                    WHEN 5 THEN 'KakaoTalk_20260322_175758277_04.jpg'
                    WHEN 6 THEN 'KakaoTalk_20260322_175758277_05.jpg'
                    WHEN 7 THEN 'KakaoTalk_20260322_175758277_06.jpg'
                    WHEN 8 THEN 'KakaoTalk_20260322_175758277_07.jpg'
                    WHEN 9 THEN 'KakaoTalk_20260322_175758277_08.jpg'
                    WHEN 10 THEN 'KakaoTalk_20260322_175758277_09.jpg'
                    WHEN 11 THEN 'KakaoTalk_20260322_175758277_10.jpg'
                    WHEN 12 THEN 'KakaoTalk_20260322_175758277_11.jpg'
                    WHEN 13 THEN 'KakaoTalk_20260322_175758277_12.jpg'
                    WHEN 14 THEN 'KakaoTalk_20260322_175758277_13.jpg'
                    WHEN 15 THEN 'KakaoTalk_20260322_175758277_14.jpg'
                    WHEN 16 THEN 'KakaoTalk_20260322_175758277_15.jpg'
                    WHEN 17 THEN 'KakaoTalk_20260322_175758277_16.jpg'
                    WHEN 18 THEN 'KakaoTalk_20260405_212404138.jpg'
                    WHEN 19 THEN 'KakaoTalk_20260405_212404138_01.jpg'
                    ELSE 'KakaoTalk_20260405_212404138_02.jpg'
                END;

            V_ORIGIN_NAME := V_IMG_FILE;

            INSERT INTO BOARD_IMG
            (
                IMG_NO, BOARD_NO, ORIGIN_NAME, CHANGE_NAME,
                FILE_PATH, FILE_LEVEL, UPLOAD_DATE
            )
            VALUES
            (
                SEQ_BOARD_IMG_NO.NEXTVAL, V_BOARD_NO, V_ORIGIN_NAME, V_IMG_FILE,
                V_FILE_PATH, 1, V_CREATE_DATE
            );
        END IF;

        -- 좋아요
        V_LIKE_CNT := MOD(I, 6); -- 0~5
        FOR K IN 1..V_LIKE_CNT LOOP
            V_LIKE_MEMBER := MOD(V_AUTHOR_NO + K - 1, 20) + 1;

            INSERT INTO BOARD_LIKE (BOARD_NO, MEMBER_NO, LIKE_TYPE)
            VALUES (V_BOARD_NO, V_LIKE_MEMBER, 'L');
        END LOOP;

        -- 댓글: 자랑은 10개 글에만
        IF I <= 10 THEN
            V_COMMENT_CNT := MOD(I, 3) + 1; -- 1~3개
            FOR C IN 1..V_COMMENT_CNT LOOP
                V_COMMENTER_NO := MOD(V_AUTHOR_NO + C + 2, 20) + 1;

                INSERT INTO BOARD_COMMENT
                (
                    COMMENT_ID, BOARD_NO, MEMBER_NO,
                    COMMENT_CONTENT, COMMENT_REG_DATE, COMMENT_ACTIVE_YN
                )
                VALUES
                (
                    SEQ_COMMENT_ID.NEXTVAL,
                    V_BOARD_NO,
                    V_COMMENTER_NO,
                    CASE MOD(C,3)
                        WHEN 1 THEN '너무 귀여워요! 사진 분위기 진짜 좋아요.'
                        WHEN 2 THEN '표정이 완전 사랑스럽네요. 자주 올려주세요!'
                        ELSE '산책 사진 느낌 좋네요. 아이가 엄청 행복해 보여요.'
                    END,
                    V_CREATE_DATE + (C / 24),
                    'Y'
                );
            END LOOP;
        END IF;
    END LOOP;

    -- =========================
    -- 2. 육아 꿀팁 30개
    -- =========================
    FOR I IN 1..30 LOOP
        V_AUTHOR_NO := MOD(I+9, 20) + 1;
        V_CATEGORY_CODE := GET_TIP_CATEGORY(I);
        V_READ_COUNT := 25 + (I * 9);
        V_CREATE_DATE := SYSDATE - (25 - I) + (I / 100);

        V_TITLE :=
            CASE V_CATEGORY_CODE
                WHEN 101 THEN '강아지 육아 꿀팁 모음 ' || I
                WHEN 102 THEN '고양이 돌봄 팁 정리 ' || I
                ELSE '초보 집사 공통 팁 ' || I
            END;

        V_CONTENT :=
            CASE V_CATEGORY_CODE
                WHEN 101 THEN '강아지 기준으로 산책 루틴, 간식 급여, 배변 습관, 장난감 활용 팁을 정리한 게시글 ' || I || '번입니다.'
                WHEN 102 THEN '고양이 기준으로 화장실 관리, 사냥놀이, 스크래처 적응, 음수량 관리 팁을 정리한 게시글 ' || I || '번입니다.'
                ELSE '강아지와 고양이 모두에게 적용할 수 있는 공통 돌봄 팁을 정리한 게시글 ' || I || '번입니다.'
            END ||
            ' 실제 테스트용으로 내용이 서로 다르게 들어가고, 작성일/조회수도 다르게 설정했습니다.';

        INSERT INTO BOARD
        (
            BOARD_NO, MEMBER_NO, BOARD_CODE, CATEGORY_CODE,
            BOARD_TITLE, BOARD_CONTENT, READ_COUNT, CREATE_DATE, BOARD_ACTIVE
        )
        VALUES
        (
            SEQ_BOARD_NO.NEXTVAL, V_AUTHOR_NO, 2, V_CATEGORY_CODE,
            V_TITLE, V_CONTENT, V_READ_COUNT, V_CREATE_DATE, 'Y'
        );

        V_BOARD_NO := SEQ_BOARD_NO.CURRVAL;

        -- 이미지: 팁 게시판 15개
        IF I <= 15 THEN
            V_IMG_FILE :=
                CASE I
                    WHEN 1 THEN 'KakaoTalk_20260405_212404138_03.jpg'
                    WHEN 2 THEN 'KakaoTalk_20260405_212404138_04.jpg'
                    WHEN 3 THEN 'KakaoTalk_20260405_212404138_05.jpg'
                    WHEN 4 THEN 'KakaoTalk_20260405_212404138_06.jpg'
                    WHEN 5 THEN 'KakaoTalk_20260405_212404138_07.jpg'
                    WHEN 6 THEN 'KakaoTalk_20260405_212404138_08.jpg'
                    WHEN 7 THEN 'KakaoTalk_20260405_212404138_09.jpg'
                    WHEN 8 THEN 'KakaoTalk_20260405_212404138_10.jpg'
                    WHEN 9 THEN 'KakaoTalk_20260405_212404138_11.jpg'
                    WHEN 10 THEN 'KakaoTalk_20260405_212404138_12.jpg'
                    WHEN 11 THEN 'KakaoTalk_20260405_212404138_13.jpg'
                    WHEN 12 THEN 'KakaoTalk_20260405_212404138_14.jpg'
                    WHEN 13 THEN 'KakaoTalk_20260405_212404138_15.jpg'
                    WHEN 14 THEN 'KakaoTalk_20260405_212404138_16.jpg'
                    ELSE 'KakaoTalk_20260405_212404138_17.jpg'
                END;

            INSERT INTO BOARD_IMG
            (
                IMG_NO, BOARD_NO, ORIGIN_NAME, CHANGE_NAME,
                FILE_PATH, FILE_LEVEL, UPLOAD_DATE
            )
            VALUES
            (
                SEQ_BOARD_IMG_NO.NEXTVAL, V_BOARD_NO, V_IMG_FILE, V_IMG_FILE,
                V_FILE_PATH, 1, V_CREATE_DATE
            );
        END IF;

        -- 좋아요
        V_LIKE_CNT := MOD(I + 2, 7); -- 0~6
        FOR K IN 1..V_LIKE_CNT LOOP
            V_LIKE_MEMBER := MOD(V_AUTHOR_NO + K + 2, 20) + 1;
            INSERT INTO BOARD_LIKE (BOARD_NO, MEMBER_NO, LIKE_TYPE)
            VALUES (V_BOARD_NO, V_LIKE_MEMBER, 'L');
        END LOOP;

        -- 댓글: 팁은 12개 글에 댓글
        IF I <= 12 THEN
            V_COMMENT_CNT := MOD(I, 4) + 1; -- 1~4개
            FOR C IN 1..V_COMMENT_CNT LOOP
                V_COMMENTER_NO := MOD(V_AUTHOR_NO + C + 5, 20) + 1;

                INSERT INTO BOARD_COMMENT
                (
                    COMMENT_ID, BOARD_NO, MEMBER_NO,
                    COMMENT_CONTENT, COMMENT_REG_DATE, COMMENT_ACTIVE_YN
                )
                VALUES
                (
                    SEQ_COMMENT_ID.NEXTVAL,
                    V_BOARD_NO,
                    V_COMMENTER_NO,
                    CASE MOD(C,4)
                        WHEN 1 THEN '팁 정리 진짜 깔끔하네요. 많이 참고됐어요.'
                        WHEN 2 THEN '저도 비슷하게 하고 있는데 효과 좋더라고요.'
                        WHEN 3 THEN '초보 보호자한테 도움 많이 될 내용 같아요.'
                        ELSE '설명 쉽게 써주셔서 이해가 잘 됐어요!'
                    END,
                    V_CREATE_DATE + (C / 24),
                    'Y'
                );
            END LOOP;
        END IF;
    END LOOP;

    -- =========================
    -- 3. 자유 게시판 30개
    -- =========================
    FOR I IN 1..30 LOOP
        V_AUTHOR_NO := MOD(I+3, 20) + 1;
        V_CATEGORY_CODE := GET_FREE_CATEGORY(I);
        V_READ_COUNT := 5 + (I * 5);
        V_CREATE_DATE := SYSDATE - (15 - I) + (I / 100);

        V_TITLE :=
            CASE V_CATEGORY_CODE
                WHEN 201 THEN '질문 있어요 도와주세요 ' || I
                WHEN 202 THEN '요즘 고민이 있어서 글 남겨요 ' || I
                ELSE '오늘 있었던 일 공유해요 ' || I
            END;

        V_CONTENT :=
            CASE V_CATEGORY_CODE
                WHEN 201 THEN '자유 게시판 질문 카테고리 샘플 글 ' || I || '번입니다. 사료, 산책, 병원, 행동 관련 질문을 자연스럽게 섞었습니다.'
                WHEN 202 THEN '자유 게시판 고민 카테고리 샘플 글 ' || I || '번입니다. 분리불안, 식사량, 배변, 사회화 관련 고민을 담았습니다.'
                ELSE '자유 게시판 자유 카테고리 샘플 글 ' || I || '번입니다. 일상, 후기, 근황, 소소한 이야기를 담았습니다.'
            END ||
            ' 테스트용 더미 데이터라 서로 다른 제목과 문장으로 넣었습니다.';

        INSERT INTO BOARD
        (
            BOARD_NO, MEMBER_NO, BOARD_CODE, CATEGORY_CODE,
            BOARD_TITLE, BOARD_CONTENT, READ_COUNT, CREATE_DATE, BOARD_ACTIVE
        )
        VALUES
        (
            SEQ_BOARD_NO.NEXTVAL, V_AUTHOR_NO, 3, V_CATEGORY_CODE,
            V_TITLE, V_CONTENT, V_READ_COUNT, V_CREATE_DATE, 'Y'
        );

        V_BOARD_NO := SEQ_BOARD_NO.CURRVAL;

        -- 이미지: 자유 게시판 10개
        IF I <= 10 THEN
            V_IMG_FILE :=
                CASE I
                    WHEN 1 THEN 'KakaoTalk_20260405_212404138_18.jpg'
                    WHEN 2 THEN 'KakaoTalk_20260405_212404138_19.jpg'
                    WHEN 3 THEN 'KakaoTalk_20260405_212404138_20.jpg'
                    WHEN 4 THEN 'KakaoTalk_20260405_212404138_21.jpg'
                    WHEN 5 THEN 'KakaoTalk_20260405_212404138_22.jpg'
                    WHEN 6 THEN 'KakaoTalk_20260405_212404138_23.jpg'
                    WHEN 7 THEN 'KakaoTalk_20260405_212404138_24.jpg'
                    WHEN 8 THEN 'KakaoTalk_20260405_212404138_25.jpg'
                    WHEN 9 THEN 'KakaoTalk_20260405_212404138_26.jpg'
                    ELSE 'KakaoTalk_20260405_212404138_27.jpg'
                END;

            INSERT INTO BOARD_IMG
            (
                IMG_NO, BOARD_NO, ORIGIN_NAME, CHANGE_NAME,
                FILE_PATH, FILE_LEVEL, UPLOAD_DATE
            )
            VALUES
            (
                SEQ_BOARD_IMG_NO.NEXTVAL, V_BOARD_NO, V_IMG_FILE, V_IMG_FILE,
                V_FILE_PATH, 1, V_CREATE_DATE
            );
        END IF;

        -- 좋아요
        V_LIKE_CNT := MOD(I + 1, 5) + 1; -- 1~5
        FOR K IN 1..V_LIKE_CNT LOOP
            V_LIKE_MEMBER := MOD(V_AUTHOR_NO + K + 6, 20) + 1;
            INSERT INTO BOARD_LIKE (BOARD_NO, MEMBER_NO, LIKE_TYPE)
            VALUES (V_BOARD_NO, V_LIKE_MEMBER, 'L');
        END LOOP;

        -- 댓글: 자유는 15개 글에 댓글
        IF I <= 15 THEN
            V_COMMENT_CNT := MOD(I, 3) + 2; -- 2~4개
            FOR C IN 1..V_COMMENT_CNT LOOP
                V_COMMENTER_NO := MOD(V_AUTHOR_NO + C + 8, 20) + 1;

                INSERT INTO BOARD_COMMENT
                (
                    COMMENT_ID, BOARD_NO, MEMBER_NO,
                    COMMENT_CONTENT, COMMENT_REG_DATE, COMMENT_ACTIVE_YN
                )
                VALUES
                (
                    SEQ_COMMENT_ID.NEXTVAL,
                    V_BOARD_NO,
                    V_COMMENTER_NO,
                    CASE MOD(C,4)
                        WHEN 1 THEN '공감돼요. 저도 비슷한 상황 겪어봤어요.'
                        WHEN 2 THEN '너무 걱정하지 마세요. 천천히 해도 괜찮아요.'
                        WHEN 3 THEN '상황 정리 잘해주셔서 읽기 편했어요.'
                        ELSE '댓글 남깁니다. 좋은 방향으로 해결되면 좋겠어요.'
                    END,
                    V_CREATE_DATE + (C / 24),
                    'Y'
                );
            END LOOP;
        END IF;
    END LOOP;

    COMMIT;
END;
/
SHOW ERRORS;

-- ============================================
-- 댓글 신고 20개
--   - 처리완료(Y) 10개 = 더 오래된 댓글 기준
--   - 미처리(N) 10개 = 최신 댓글 기준
-- ============================================

DECLARE
    V_IDX NUMBER := 0;
BEGIN
    -- 처리 완료 10개 (오래된 댓글)
    FOR R IN (
        SELECT *
          FROM (
                SELECT BC.COMMENT_ID,
                       BC.MEMBER_NO AS COMMENT_WRITER
                  FROM BOARD_COMMENT BC
                  JOIN BOARD B ON B.BOARD_NO = BC.BOARD_NO
                 WHERE B.BOARD_CODE IN (1,2,3)
                 ORDER BY BC.COMMENT_REG_DATE ASC, BC.COMMENT_ID ASC
               )
         WHERE ROWNUM <= 10
    ) LOOP
        V_IDX := V_IDX + 1;

        INSERT INTO COMMENT_REPORT
        (
            REPORT_ID, REPORTER_MEMBER_NO, COMMENT_ID,
            REPORT_TYPE_ID, REPORT_REASON, REPORT_DATE, REPORT_PROCESS_YN
        )
        VALUES
        (
            SEQ_COMMENT_REPORT_ID.NEXTVAL,
            CASE
                WHEN MOD(R.COMMENT_WRITER, 20) + 1 = R.COMMENT_WRITER THEN MOD(R.COMMENT_WRITER + 1, 20) + 1
                ELSE MOD(R.COMMENT_WRITER, 20) + 1
            END,
            R.COMMENT_ID,
            CASE MOD(V_IDX, 3) WHEN 1 THEN 1 WHEN 2 THEN 2 ELSE 3 END,
            CASE MOD(V_IDX, 3)
                WHEN 1 THEN '댓글 표현이 거칠어서 신고합니다.'
                WHEN 2 THEN '광고성으로 보여서 신고합니다.'
                ELSE '커뮤니티 분위기와 맞지 않는 내용입니다.'
            END,
            SYSDATE - 10 + (V_IDX / 24),
            'Y'
        );
    END LOOP;

    V_IDX := 0;

    -- 미처리 10개 (최신 댓글)
    FOR R IN (
        SELECT *
          FROM (
                SELECT BC.COMMENT_ID,
                       BC.MEMBER_NO AS COMMENT_WRITER
                  FROM BOARD_COMMENT BC
                  JOIN BOARD B ON B.BOARD_NO = BC.BOARD_NO
                 WHERE B.BOARD_CODE IN (1,2,3)
                 ORDER BY BC.COMMENT_REG_DATE DESC, BC.COMMENT_ID DESC
               )
         WHERE ROWNUM <= 10
    ) LOOP
        V_IDX := V_IDX + 1;

        INSERT INTO COMMENT_REPORT
        (
            REPORT_ID, REPORTER_MEMBER_NO, COMMENT_ID,
            REPORT_TYPE_ID, REPORT_REASON, REPORT_DATE, REPORT_PROCESS_YN
        )
        VALUES
        (
            SEQ_COMMENT_REPORT_ID.NEXTVAL,
            CASE
                WHEN MOD(R.COMMENT_WRITER + 3, 20) + 1 = R.COMMENT_WRITER THEN MOD(R.COMMENT_WRITER + 4, 20) + 1
                ELSE MOD(R.COMMENT_WRITER + 3, 20) + 1
            END,
            R.COMMENT_ID,
            CASE MOD(V_IDX, 3) WHEN 1 THEN 1 WHEN 2 THEN 2 ELSE 3 END,
            CASE MOD(V_IDX, 3)
                WHEN 1 THEN '최근 댓글 중 부적절한 표현이 있어 신고합니다.'
                WHEN 2 THEN '최근 댓글이 광고성 같아서 신고합니다.'
                ELSE '최근 댓글 내용 확인이 필요해 보여 신고합니다.'
            END,
            SYSDATE - (V_IDX / 48),
            'N'
        );
    END LOOP;

    COMMIT;
END;
/
SHOW ERRORS;

-- ============================================
-- 확인용 SELECT
-- ============================================
PROMPT ===== BOARD COUNT =====
SELECT BOARD_CODE, COUNT(*) AS CNT
  FROM BOARD
 GROUP BY BOARD_CODE
 ORDER BY BOARD_CODE;

PROMPT ===== COMMENT REPORT COUNT =====
SELECT REPORT_PROCESS_YN, COUNT(*) AS CNT
  FROM COMMENT_REPORT
 GROUP BY REPORT_PROCESS_YN
 ORDER BY REPORT_PROCESS_YN;

PROMPT ===== LATEST UNPROCESSED REPORTS =====
SELECT *
  FROM (
        SELECT CR.REPORT_ID,
               CR.COMMENT_ID,
               CR.REPORT_DATE,
               CR.REPORT_PROCESS_YN
          FROM COMMENT_REPORT CR
         WHERE CR.REPORT_PROCESS_YN = 'N'
         ORDER BY CR.REPORT_DATE DESC, CR.REPORT_ID DESC
       )
 WHERE ROWNUM <= 10;

UPDATE BOARD_IMG
SET FILE_PATH = '/resources/images/community/'
WHERE FILE_PATH <> '/resources/images/community/';

-- 자랑 게시판(BOARD_CODE=1) 중 이미지 없는 글만 찾아서
-- BOARD_IMG 1개씩 강제로 넣기

DECLARE
    V_RN NUMBER := 0;
    V_FILE_NAME VARCHAR2(200);
BEGIN
    FOR R IN (
        SELECT B.BOARD_NO
        FROM BOARD B
        WHERE B.BOARD_CODE = 1
          AND NOT EXISTS (
              SELECT 1
              FROM BOARD_IMG BI
              WHERE BI.BOARD_NO = B.BOARD_NO
          )
        ORDER BY B.BOARD_NO
    ) LOOP
        V_RN := V_RN + 1;

        V_FILE_NAME :=
            CASE V_RN
                WHEN 1 THEN 'KakaoTalk_20260405_212404138_28.jpg'
                WHEN 2 THEN 'KakaoTalk_20260405_212404138_29.jpg'
                WHEN 3 THEN 'KakaoTalk_20260405_212424492.jpg'
                WHEN 4 THEN 'KakaoTalk_20260405_212424492_01.jpg'
                WHEN 5 THEN 'KakaoTalk_20260405_212424492_02.jpg'
                WHEN 6 THEN 'KakaoTalk_20260405_212424492_03.jpg'
                WHEN 7 THEN 'KakaoTalk_20260405_212424492_04.jpg'
                WHEN 8 THEN 'KakaoTalk_20260405_212424492_05.jpg'
                WHEN 9 THEN 'KakaoTalk_20260405_212424492_06.jpg'
                ELSE 'KakaoTalk_20260405_212424492_07.jpg'
            END;

        INSERT INTO BOARD_IMG
        (
            IMG_NO,
            BOARD_NO,
            ORIGIN_NAME,
            CHANGE_NAME,
            FILE_PATH,
            FILE_LEVEL,
            UPLOAD_DATE
        )
        VALUES
        (
            SEQ_BOARD_IMG_NO.NEXTVAL,
            R.BOARD_NO,
            V_FILE_NAME,
            V_FILE_NAME,
            '/resources/images/community/',
            1,
            SYSDATE
        );
    END LOOP;

    COMMIT;
END;
/


DECLARE
    V_IDX NUMBER := 0;
    V_FILE_NAME VARCHAR2(200);
BEGIN
    FOR R IN (
        SELECT B.BOARD_NO, B.BOARD_CODE
        FROM BOARD B
        WHERE B.BOARD_CODE IN (1, 2)
          AND NOT EXISTS (
              SELECT 1
              FROM BOARD_IMG BI
              WHERE BI.BOARD_NO = B.BOARD_NO
          )
        ORDER BY B.BOARD_CODE, B.BOARD_NO
    ) LOOP
        V_IDX := V_IDX + 1;

        V_FILE_NAME :=
            CASE MOD(V_IDX - 1, 40)
                WHEN 0 THEN 'KakaoTalk_20260322_175758277.jpg'
                WHEN 1 THEN 'KakaoTalk_20260322_175758277_01.jpg'
                WHEN 2 THEN 'KakaoTalk_20260322_175758277_02.jpg'
                WHEN 3 THEN 'KakaoTalk_20260322_175758277_03.jpg'
                WHEN 4 THEN 'KakaoTalk_20260322_175758277_04.jpg'
                WHEN 5 THEN 'KakaoTalk_20260322_175758277_05.jpg'
                WHEN 6 THEN 'KakaoTalk_20260322_175758277_06.jpg'
                WHEN 7 THEN 'KakaoTalk_20260322_175758277_07.jpg'
                WHEN 8 THEN 'KakaoTalk_20260322_175758277_08.jpg'
                WHEN 9 THEN 'KakaoTalk_20260322_175758277_09.jpg'
                WHEN 10 THEN 'KakaoTalk_20260322_175758277_10.jpg'
                WHEN 11 THEN 'KakaoTalk_20260322_175758277_11.jpg'
                WHEN 12 THEN 'KakaoTalk_20260322_175758277_12.jpg'
                WHEN 13 THEN 'KakaoTalk_20260322_175758277_13.jpg'
                WHEN 14 THEN 'KakaoTalk_20260322_175758277_14.jpg'
                WHEN 15 THEN 'KakaoTalk_20260322_175758277_15.jpg'
                WHEN 16 THEN 'KakaoTalk_20260322_175758277_16.jpg'
                WHEN 17 THEN 'KakaoTalk_20260405_212404138.jpg'
                WHEN 18 THEN 'KakaoTalk_20260405_212404138_01.jpg'
                WHEN 19 THEN 'KakaoTalk_20260405_212404138_02.jpg'
                WHEN 20 THEN 'KakaoTalk_20260405_212404138_03.jpg'
                WHEN 21 THEN 'KakaoTalk_20260405_212404138_04.jpg'
                WHEN 22 THEN 'KakaoTalk_20260405_212404138_05.jpg'
                WHEN 23 THEN 'KakaoTalk_20260405_212404138_06.jpg'
                WHEN 24 THEN 'KakaoTalk_20260405_212404138_07.jpg'
                WHEN 25 THEN 'KakaoTalk_20260405_212404138_08.jpg'
                WHEN 26 THEN 'KakaoTalk_20260405_212404138_09.jpg'
                WHEN 27 THEN 'KakaoTalk_20260405_212404138_10.jpg'
                WHEN 28 THEN 'KakaoTalk_20260405_212404138_11.jpg'
                WHEN 29 THEN 'KakaoTalk_20260405_212404138_12.jpg'
                WHEN 30 THEN 'KakaoTalk_20260405_212404138_13.jpg'
                WHEN 31 THEN 'KakaoTalk_20260405_212404138_14.jpg'
                WHEN 32 THEN 'KakaoTalk_20260405_212404138_15.jpg'
                WHEN 33 THEN 'KakaoTalk_20260405_212404138_16.jpg'
                WHEN 34 THEN 'KakaoTalk_20260405_212404138_17.jpg'
                WHEN 35 THEN 'KakaoTalk_20260405_212404138_18.jpg'
                WHEN 36 THEN 'KakaoTalk_20260405_212404138_19.jpg'
                WHEN 37 THEN 'KakaoTalk_20260405_212404138_20.jpg'
                WHEN 38 THEN 'KakaoTalk_20260405_212404138_21.jpg'
                ELSE 'KakaoTalk_20260405_212404138_22.jpg'
            END;

        INSERT INTO BOARD_IMG
        (
            IMG_NO,
            BOARD_NO,
            ORIGIN_NAME,
            CHANGE_NAME,
            FILE_PATH,
            FILE_LEVEL,
            UPLOAD_DATE
        )
        VALUES
        (
            SEQ_BOARD_IMG_NO.NEXTVAL,
            R.BOARD_NO,
            V_FILE_NAME,
            V_FILE_NAME,
            '/resources/images/community/',
            1,
            SYSDATE
        );
    END LOOP;

    COMMIT;
END;
/


DECLARE
    V_IDX NUMBER := 0;
    V_FILE_NAME VARCHAR2(200);
BEGIN
    FOR R IN (
        SELECT B.BOARD_NO
        FROM BOARD B
        WHERE B.BOARD_CODE IN (1, 2, 3)
        ORDER BY B.BOARD_NO
    ) LOOP
        V_IDX := V_IDX + 1;

        V_FILE_NAME :=
            CASE MOD(V_IDX - 1, 50)
                WHEN 0 THEN 'KakaoTalk_20260322_175758277.jpg'
                WHEN 1 THEN 'KakaoTalk_20260322_175758277_01.jpg'
                WHEN 2 THEN 'KakaoTalk_20260322_175758277_02.jpg'
                WHEN 3 THEN 'KakaoTalk_20260322_175758277_03.jpg'
                WHEN 4 THEN 'KakaoTalk_20260322_175758277_04.jpg'
                WHEN 5 THEN 'KakaoTalk_20260322_175758277_05.jpg'
                WHEN 6 THEN 'KakaoTalk_20260322_175758277_06.jpg'
                WHEN 7 THEN 'KakaoTalk_20260322_175758277_07.jpg'
                WHEN 8 THEN 'KakaoTalk_20260322_175758277_08.jpg'
                WHEN 9 THEN 'KakaoTalk_20260322_175758277_09.jpg'
                WHEN 10 THEN 'KakaoTalk_20260322_175758277_10.jpg'
                WHEN 11 THEN 'KakaoTalk_20260322_175758277_11.jpg'
                WHEN 12 THEN 'KakaoTalk_20260322_175758277_12.jpg'
                WHEN 13 THEN 'KakaoTalk_20260322_175758277_13.jpg'
                WHEN 14 THEN 'KakaoTalk_20260322_175758277_14.jpg'
                WHEN 15 THEN 'KakaoTalk_20260322_175758277_15.jpg'
                WHEN 16 THEN 'KakaoTalk_20260322_175758277_16.jpg'
                WHEN 17 THEN 'KakaoTalk_20260405_212404138.jpg'
                WHEN 18 THEN 'KakaoTalk_20260405_212404138_01.jpg'
                WHEN 19 THEN 'KakaoTalk_20260405_212404138_02.jpg'
                WHEN 20 THEN 'KakaoTalk_20260405_212404138_03.jpg'
                WHEN 21 THEN 'KakaoTalk_20260405_212404138_04.jpg'
                WHEN 22 THEN 'KakaoTalk_20260405_212404138_05.jpg'
                WHEN 23 THEN 'KakaoTalk_20260405_212404138_06.jpg'
                WHEN 24 THEN 'KakaoTalk_20260405_212404138_07.jpg'
                WHEN 25 THEN 'KakaoTalk_20260405_212404138_08.jpg'
                WHEN 26 THEN 'KakaoTalk_20260405_212404138_09.jpg'
                WHEN 27 THEN 'KakaoTalk_20260405_212404138_10.jpg'
                WHEN 28 THEN 'KakaoTalk_20260405_212404138_11.jpg'
                WHEN 29 THEN 'KakaoTalk_20260405_212404138_12.jpg'
                WHEN 30 THEN 'KakaoTalk_20260405_212404138_13.jpg'
                WHEN 31 THEN 'KakaoTalk_20260405_212404138_14.jpg'
                WHEN 32 THEN 'KakaoTalk_20260405_212404138_15.jpg'
                WHEN 33 THEN 'KakaoTalk_20260405_212404138_16.jpg'
                WHEN 34 THEN 'KakaoTalk_20260405_212404138_17.jpg'
                WHEN 35 THEN 'KakaoTalk_20260405_212404138_18.jpg'
                WHEN 36 THEN 'KakaoTalk_20260405_212404138_19.jpg'
                WHEN 37 THEN 'KakaoTalk_20260405_212404138_20.jpg'
                WHEN 38 THEN 'KakaoTalk_20260405_212404138_21.jpg'
                WHEN 39 THEN 'KakaoTalk_20260405_212404138_22.jpg'
                WHEN 40 THEN 'KakaoTalk_20260405_212404138_23.jpg'
                WHEN 41 THEN 'KakaoTalk_20260405_212404138_24.jpg'
                WHEN 42 THEN 'KakaoTalk_20260405_212404138_25.jpg'
                WHEN 43 THEN 'KakaoTalk_20260405_212404138_26.jpg'
                WHEN 44 THEN 'KakaoTalk_20260405_212404138_27.jpg'
                WHEN 45 THEN 'KakaoTalk_20260405_212404138_28.jpg'
                WHEN 46 THEN 'KakaoTalk_20260405_212404138_29.jpg'
                WHEN 47 THEN 'KakaoTalk_20260405_212424492.jpg'
                WHEN 48 THEN 'KakaoTalk_20260405_212424492_01.jpg'
                ELSE 'KakaoTalk_20260405_212424492_02.jpg'
            END;

        INSERT INTO BOARD_IMG
        (
            IMG_NO,
            BOARD_NO,
            ORIGIN_NAME,
            CHANGE_NAME,
            FILE_PATH,
            FILE_LEVEL,
            UPLOAD_DATE
        )
        VALUES
        (
            SEQ_BOARD_IMG_NO.NEXTVAL,
            R.BOARD_NO,
            V_FILE_NAME,
            V_FILE_NAME,
            '/resources/images/community/',
            1,
            SYSDATE
        );
    END LOOP;

    COMMIT;
END;
/
COMMIT;
