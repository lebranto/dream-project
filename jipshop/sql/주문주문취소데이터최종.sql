-- =========================
-- 기존 주문 더미만 삭제
-- =========================

DELETE FROM STATUS
WHERE DELIVERY_ID IN (
    SELECT D.DELIVERY_ID
    FROM DELIVERY D
    JOIN ORDERS O ON D.ORDER_ID = O.ORDER_ID
    WHERE O.ORDERER_NAME LIKE '주문테스트%'
       OR O.ORDERER_NAME LIKE '취소주문테스트%'
       OR O.ORDERER_NAME LIKE '정상주문더미%'
       OR O.ORDERER_NAME LIKE '부분취소더미%'
       OR O.ORDERER_NAME LIKE '전체취소더미%'
       OR O.ORDER_MEMO   LIKE '정상주문 테스트 데이터%'
       OR O.ORDER_MEMO   LIKE '취소주문 테스트 데이터%'
       OR O.ORDER_MEMO   LIKE '정상주문 더미%'
       OR O.ORDER_MEMO   LIKE '부분취소 더미%'
       OR O.ORDER_MEMO   LIKE '전체취소 더미%'
);

DELETE FROM DELIVERY
WHERE ORDER_ID IN (
    SELECT O.ORDER_ID
    FROM ORDERS O
    WHERE O.ORDERER_NAME LIKE '주문테스트%'
       OR O.ORDERER_NAME LIKE '취소주문테스트%'
       OR O.ORDERER_NAME LIKE '정상주문더미%'
       OR O.ORDERER_NAME LIKE '부분취소더미%'
       OR O.ORDERER_NAME LIKE '전체취소더미%'
       OR O.ORDER_MEMO   LIKE '정상주문 테스트 데이터%'
       OR O.ORDER_MEMO   LIKE '취소주문 테스트 데이터%'
       OR O.ORDER_MEMO   LIKE '정상주문 더미%'
       OR O.ORDER_MEMO   LIKE '부분취소 더미%'
       OR O.ORDER_MEMO   LIKE '전체취소 더미%'
);

DELETE FROM ORDER_DETAIL
WHERE ORDER_ID IN (
    SELECT O.ORDER_ID
    FROM ORDERS O
    WHERE O.ORDERER_NAME LIKE '주문테스트%'
       OR O.ORDERER_NAME LIKE '취소주문테스트%'
       OR O.ORDERER_NAME LIKE '정상주문더미%'
       OR O.ORDERER_NAME LIKE '부분취소더미%'
       OR O.ORDERER_NAME LIKE '전체취소더미%'
       OR O.ORDER_MEMO   LIKE '정상주문 테스트 데이터%'
       OR O.ORDER_MEMO   LIKE '취소주문 테스트 데이터%'
       OR O.ORDER_MEMO   LIKE '정상주문 더미%'
       OR O.ORDER_MEMO   LIKE '부분취소 더미%'
       OR O.ORDER_MEMO   LIKE '전체취소 더미%'
);

DELETE FROM ORDERS
WHERE ORDERER_NAME LIKE '주문테스트%'
   OR ORDERER_NAME LIKE '취소주문테스트%'
   OR ORDERER_NAME LIKE '정상주문더미%'
   OR ORDERER_NAME LIKE '부분취소더미%'
   OR ORDERER_NAME LIKE '전체취소더미%'
   OR ORDER_MEMO   LIKE '정상주문 테스트 데이터%'
   OR ORDER_MEMO   LIKE '취소주문 테스트 데이터%'
   OR ORDER_MEMO   LIKE '정상주문 더미%'
   OR ORDER_MEMO   LIKE '부분취소 더미%'
   OR ORDER_MEMO   LIKE '전체취소 더미%';

DECLARE
    v_member_no        MEMBER.MEMBER_NO%TYPE;
    v_order_id         ORDERS.ORDER_ID%TYPE;
    v_delivery_id      DELIVERY.DELIVERY_ID%TYPE;

    v_product_id1      PRODUCT.PRODUCT_ID%TYPE;
    v_product_id2      PRODUCT.PRODUCT_ID%TYPE;

    v_price1           PRODUCT.PRODUCT_PRICE%TYPE;
    v_price2           PRODUCT.PRODUCT_PRICE%TYPE;

    v_qty1             NUMBER;
    v_qty2             NUMBER;

    v_total_price      NUMBER;
    v_delivery_fee     NUMBER;

    v_reason           VARCHAR2(200);
    v_order_date       DATE;
    v_cancel_date      DATE;
    v_status           VARCHAR2(20);
    v_delivery_status  VARCHAR2(20);
    v_delivery_yn      CHAR(1);

    ----------------------------------------------------------------
    -- 회원 20명 중 랜덤 1명
    ----------------------------------------------------------------
    PROCEDURE get_random_member(p_member_no OUT NUMBER) IS
    BEGIN
        SELECT member_no
          INTO p_member_no
          FROM (
                SELECT member_no
                  FROM (
                        SELECT member_no
                          FROM MEMBER
                         ORDER BY member_no
                       )
                 WHERE ROWNUM <= 20
                 ORDER BY DBMS_RANDOM.VALUE
               )
         WHERE ROWNUM = 1;
    END;

    ----------------------------------------------------------------
    -- 활성 상품 랜덤 1개
    ----------------------------------------------------------------
    PROCEDURE get_random_product(
        p_product_id OUT NUMBER,
        p_price      OUT NUMBER
    ) IS
    BEGIN
        SELECT product_id, product_price
          INTO p_product_id, p_price
          FROM (
                SELECT product_id, product_price
                  FROM PRODUCT
                 WHERE PRODUCT_ACTIVE_YN = 'Y'
                 ORDER BY DBMS_RANDOM.VALUE
               )
         WHERE ROWNUM = 1;
    END;

    ----------------------------------------------------------------
    -- 활성 상품 랜덤 1개 (특정 상품 제외)
    ----------------------------------------------------------------
    PROCEDURE get_random_product_exclude(
        p_exclude_id IN NUMBER,
        p_product_id OUT NUMBER,
        p_price      OUT NUMBER
    ) IS
    BEGIN
        SELECT product_id, product_price
          INTO p_product_id, p_price
          FROM (
                SELECT product_id, product_price
                  FROM PRODUCT
                 WHERE PRODUCT_ACTIVE_YN = 'Y'
                   AND PRODUCT_ID <> p_exclude_id
                 ORDER BY DBMS_RANDOM.VALUE
               )
         WHERE ROWNUM = 1;
    END;

    ----------------------------------------------------------------
    -- 취소 사유 랜덤
    ----------------------------------------------------------------
    FUNCTION get_reason(p_idx NUMBER) RETURN VARCHAR2 IS
    BEGIN
        RETURN CASE MOD(p_idx, 5)
                 WHEN 0 THEN '단순 변심'
                 WHEN 1 THEN '주문 실수'
                 WHEN 2 THEN '상품 불량'
                 WHEN 3 THEN '오배송'
                 ELSE '배송 지연'
               END;
    END;

    ----------------------------------------------------------------
    -- 배송 상태 랜덤
    ----------------------------------------------------------------
    FUNCTION get_delivery_status(p_idx NUMBER) RETURN VARCHAR2 IS
    BEGIN
        RETURN CASE MOD(p_idx, 4)
                 WHEN 0 THEN '결제완료'
                 WHEN 1 THEN '출고완료'
                 WHEN 2 THEN '배송중'
                 ELSE '배송완료'
               END;
    END;

BEGIN
    ----------------------------------------------------------------
    -- 정상주문 40개
    ----------------------------------------------------------------
    FOR i IN 1..40 LOOP
        get_random_member(v_member_no);

        get_random_product(v_product_id1, v_price1);

        v_qty1 := CASE WHEN MOD(i, 3) = 0 THEN 2 ELSE 1 END;
        v_total_price := v_price1 * v_qty1;
        v_delivery_fee := CASE WHEN v_total_price >= 30000 THEN 0 ELSE 3000 END;
        v_order_date := SYSDATE - TRUNC(DBMS_RANDOM.VALUE(1, 20));

        v_order_id := SEQ_ORDER.NEXTVAL;
        v_delivery_id := SEQ_DELIVERY.NEXTVAL;

        INSERT INTO ORDERS (
            ORDER_ID, MEMBER_NO, ORDER_DATE,
            ORDER_TOTAL_PRICE, ORDER_DELIVERY_FEE,
            ORDERER_NAME, ORDERER_PHONE, ORDERER_EMAIL,
            RECV_NAME, RECV_ADDRESS, RECV_PHONE,
            ORDER_MEMO, ORDER_CANCEL_YN,
            CANCEL_REQUEST_DATE, CANCEL_REASON, CANCEL_STATUS
        ) VALUES (
            v_order_id, v_member_no, v_order_date,
            v_total_price, v_delivery_fee,
            '정상주문더미' || i,
            '010-11' || LPAD(MOD(i,100), 2, '0') || '-' || LPAD(i, 4, '0'),
            'normal' || i || '@test.com',
            '수령인N' || i,
            '서울시 강남구 정상주문로 ' || i,
            '010-21' || LPAD(MOD(i,100), 2, '0') || '-' || LPAD(i, 4, '0'),
            '정상주문 더미 ' || i,
            'N',
            NULL, NULL, NULL
        );

        INSERT INTO ORDER_DETAIL (
            DETAIL_ID, ORDER_ID, PRODUCT_ID, DETAIL_QTY, DETAIL_PRICE,
            CANCEL_YN, CANCEL_STATUS, CANCEL_REQUEST_DATE, CANCEL_REASON
        ) VALUES (
            SEQ_DETAIL.NEXTVAL, v_order_id, v_product_id1, v_qty1, v_price1,
            'N', 'NONE', NULL, NULL
        );

        v_delivery_status := get_delivery_status(i);
        v_delivery_yn := CASE WHEN v_delivery_status = '배송완료' THEN 'Y' ELSE 'N' END;

        INSERT INTO DELIVERY (
            DELIVERY_ID, ORDER_ID, COURIER, EXPECTED_DATE
        ) VALUES (
            v_delivery_id, v_order_id,
            CASE WHEN MOD(i, 2) = 0 THEN 'CJ대한통운' ELSE '롯데택배' END,
            v_order_date + TRUNC(DBMS_RANDOM.VALUE(1, 4))
        );

        INSERT INTO STATUS (
            DNUM, DELIVERY_YN, DELIVERY_STATUS, DELIVERY_ID
        ) VALUES (
            'S' || LPAD(v_delivery_id, 8, '0'),
            v_delivery_yn,
            v_delivery_status,
            v_delivery_id
        );
    END LOOP;

    ----------------------------------------------------------------
    -- 부분취소 20개
    -- 주문당 상세 2개: 1개 취소, 1개 정상
    ----------------------------------------------------------------
    FOR i IN 1..20 LOOP
        get_random_member(v_member_no);

        get_random_product(v_product_id1, v_price1);
        get_random_product_exclude(v_product_id1, v_product_id2, v_price2);

        v_qty1 := CASE WHEN MOD(i, 2) = 0 THEN 1 ELSE 2 END;
        v_qty2 := CASE WHEN MOD(i, 3) = 0 THEN 2 ELSE 1 END;

        v_total_price := (v_price1 * v_qty1) + (v_price2 * v_qty2);
        v_delivery_fee := CASE WHEN v_total_price >= 30000 THEN 0 ELSE 3000 END;

        v_order_date := SYSDATE - TRUNC(DBMS_RANDOM.VALUE(3, 25));
        v_cancel_date := v_order_date + TRUNC(DBMS_RANDOM.VALUE(1, 3));
        v_reason := get_reason(i);
        v_status := CASE MOD(i, 3)
                      WHEN 0 THEN 'PENDING'
                      WHEN 1 THEN 'APPROVED'
                      ELSE 'REJECTED'
                    END;

        v_order_id := SEQ_ORDER.NEXTVAL;
        v_delivery_id := SEQ_DELIVERY.NEXTVAL;

        INSERT INTO ORDERS (
            ORDER_ID, MEMBER_NO, ORDER_DATE,
            ORDER_TOTAL_PRICE, ORDER_DELIVERY_FEE,
            ORDERER_NAME, ORDERER_PHONE, ORDERER_EMAIL,
            RECV_NAME, RECV_ADDRESS, RECV_PHONE,
            ORDER_MEMO, ORDER_CANCEL_YN,
            CANCEL_REQUEST_DATE, CANCEL_REASON, CANCEL_STATUS
        ) VALUES (
            v_order_id, v_member_no, v_order_date,
            v_total_price, v_delivery_fee,
            '부분취소더미' || i,
            '010-33' || LPAD(MOD(i,100), 2, '0') || '-' || LPAD(i, 4, '0'),
            'partial' || i || '@test.com',
            '수령인P' || i,
            '서울시 송파구 부분취소로 ' || i,
            '010-44' || LPAD(MOD(i,100), 2, '0') || '-' || LPAD(i, 4, '0'),
            '부분취소 더미 ' || i,
            'Y',
            v_cancel_date,
            v_reason,
            v_status
        );

        -- 첫 번째 상품: 취소
        INSERT INTO ORDER_DETAIL (
            DETAIL_ID, ORDER_ID, PRODUCT_ID, DETAIL_QTY, DETAIL_PRICE,
            CANCEL_YN, CANCEL_STATUS, CANCEL_REQUEST_DATE, CANCEL_REASON
        ) VALUES (
            SEQ_DETAIL.NEXTVAL, v_order_id, v_product_id1, v_qty1, v_price1,
            'Y', v_status, v_cancel_date, v_reason
        );

        -- 두 번째 상품: 정상
        INSERT INTO ORDER_DETAIL (
            DETAIL_ID, ORDER_ID, PRODUCT_ID, DETAIL_QTY, DETAIL_PRICE,
            CANCEL_YN, CANCEL_STATUS, CANCEL_REQUEST_DATE, CANCEL_REASON
        ) VALUES (
            SEQ_DETAIL.NEXTVAL, v_order_id, v_product_id2, v_qty2, v_price2,
            'N', 'NONE', NULL, NULL
        );

        v_delivery_status := get_delivery_status(i + 40);
        v_delivery_yn := CASE WHEN v_delivery_status = '배송완료' THEN 'Y' ELSE 'N' END;

        INSERT INTO DELIVERY (
            DELIVERY_ID, ORDER_ID, COURIER, EXPECTED_DATE
        ) VALUES (
            v_delivery_id, v_order_id,
            CASE WHEN MOD(i, 2) = 0 THEN 'CJ대한통운' ELSE '한진택배' END,
            v_order_date + TRUNC(DBMS_RANDOM.VALUE(1, 4))
        );

        INSERT INTO STATUS (
            DNUM, DELIVERY_YN, DELIVERY_STATUS, DELIVERY_ID
        ) VALUES (
            'S' || LPAD(v_delivery_id, 8, '0'),
            v_delivery_yn,
            v_delivery_status,
            v_delivery_id
        );
    END LOOP;

    ----------------------------------------------------------------
    -- 전체취소 10개
    -- 주문당 상세 2개 모두 취소
    ----------------------------------------------------------------
    FOR i IN 1..10 LOOP
        get_random_member(v_member_no);

        get_random_product(v_product_id1, v_price1);
        get_random_product_exclude(v_product_id1, v_product_id2, v_price2);

        v_qty1 := CASE WHEN MOD(i, 2) = 0 THEN 2 ELSE 1 END;
        v_qty2 := 1;

        v_total_price := (v_price1 * v_qty1) + (v_price2 * v_qty2);
        v_delivery_fee := CASE WHEN v_total_price >= 30000 THEN 0 ELSE 3000 END;

        v_order_date := SYSDATE - TRUNC(DBMS_RANDOM.VALUE(5, 30));
        v_cancel_date := v_order_date + TRUNC(DBMS_RANDOM.VALUE(1, 2));
        v_reason := get_reason(i + 20);
        v_status := CASE MOD(i, 3)
                      WHEN 0 THEN 'PENDING'
                      WHEN 1 THEN 'APPROVED'
                      ELSE 'REJECTED'
                    END;

        v_order_id := SEQ_ORDER.NEXTVAL;
        v_delivery_id := SEQ_DELIVERY.NEXTVAL;

        INSERT INTO ORDERS (
            ORDER_ID, MEMBER_NO, ORDER_DATE,
            ORDER_TOTAL_PRICE, ORDER_DELIVERY_FEE,
            ORDERER_NAME, ORDERER_PHONE, ORDERER_EMAIL,
            RECV_NAME, RECV_ADDRESS, RECV_PHONE,
            ORDER_MEMO, ORDER_CANCEL_YN,
            CANCEL_REQUEST_DATE, CANCEL_REASON, CANCEL_STATUS
        ) VALUES (
            v_order_id, v_member_no, v_order_date,
            v_total_price, v_delivery_fee,
            '전체취소더미' || i,
            '010-55' || LPAD(MOD(i,100), 2, '0') || '-' || LPAD(i, 4, '0'),
            'fullcancel' || i || '@test.com',
            '수령인F' || i,
            '서울시 마포구 전체취소로 ' || i,
            '010-66' || LPAD(MOD(i,100), 2, '0') || '-' || LPAD(i, 4, '0'),
            '전체취소 더미 ' || i,
            'Y',
            v_cancel_date,
            v_reason,
            v_status
        );

        INSERT INTO ORDER_DETAIL (
            DETAIL_ID, ORDER_ID, PRODUCT_ID, DETAIL_QTY, DETAIL_PRICE,
            CANCEL_YN, CANCEL_STATUS, CANCEL_REQUEST_DATE, CANCEL_REASON
        ) VALUES (
            SEQ_DETAIL.NEXTVAL, v_order_id, v_product_id1, v_qty1, v_price1,
            'Y', v_status, v_cancel_date, v_reason
        );

        INSERT INTO ORDER_DETAIL (
            DETAIL_ID, ORDER_ID, PRODUCT_ID, DETAIL_QTY, DETAIL_PRICE,
            CANCEL_YN, CANCEL_STATUS, CANCEL_REQUEST_DATE, CANCEL_REASON
        ) VALUES (
            SEQ_DETAIL.NEXTVAL, v_order_id, v_product_id2, v_qty2, v_price2,
            'Y', v_status, v_cancel_date, v_reason
        );

        -- 전체취소는 배송 전 단계 위주
        v_delivery_status := CASE MOD(i, 3)
                               WHEN 0 THEN '결제완료'
                               WHEN 1 THEN '출고완료'
                               ELSE '배송중'
                             END;
        v_delivery_yn := 'N';

        INSERT INTO DELIVERY (
            DELIVERY_ID, ORDER_ID, COURIER, EXPECTED_DATE
        ) VALUES (
            v_delivery_id, v_order_id,
            CASE WHEN MOD(i, 2) = 0 THEN '롯데택배' ELSE 'CJ대한통운' END,
            v_order_date + 2
        );

        INSERT INTO STATUS (
            DNUM, DELIVERY_YN, DELIVERY_STATUS, DELIVERY_ID
        ) VALUES (
            'S' || LPAD(v_delivery_id, 8, '0'),
            v_delivery_yn,
            v_delivery_status,
            v_delivery_id
        );
    END LOOP;

    COMMIT;
END;
/
COMMIT;