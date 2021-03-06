DROP TABLE IF EXISTS SGT_ACCOUNT_TUMBLER CASCADE;
DROP TABLE IF EXISTS SGT_ACCOUNT CASCADE;
DROP TABLE IF EXISTS SGT_MENU CASCADE;
DROP TABLE IF EXISTS SGT_TUMBLER CASCADE;
DROP TABLE IF EXISTS SGT_PRIVATE_MENU CASCADE;
DROP TABLE IF EXISTS SGT_PERSONAL_OPTION CASCADE;
DROP TABLE IF EXISTS SGT_ORDER CASCADE;
DROP TABLE IF EXISTS SGT_ORDERDETAILS CASCADE;
DROP TABLE IF EXISTS SGT_ALARM CASCADE;
DROP TABLE IF EXISTS SGT_ALARM_ORDER CASCADE;


DROP SEQUENCE IF EXISTS SGT_MENU_SEQ;
DROP SEQUENCE IF EXISTS SGT_TUMBLER_SEQ;
DROP SEQUENCE IF EXISTS SGT_OPTION_SEQ;
DROP SEQUENCE IF EXISTS SGT_ORDER_SEQ;
DROP SEQUENCE IF EXISTS SGT_PRIVATE_MENU_SEQ;
DROP SEQUENCE IF EXISTS SGT_ALARM_SEQ;
DROP SEQUENCE IF EXISTS SGT_ALARM_ORDER_SEQ;

CREATE SEQUENCE SGT_MENU_SEQ 			START 1;
CREATE SEQUENCE SGT_TUMBLER_SEQ 		START 1;
CREATE SEQUENCE SGT_OPTION_SEQ			START 1;
CREATE SEQUENCE SGT_ORDER_SEQ			START 1;
CREATE SEQUENCE SGT_PRIVATE_MENU_SEQ	START 1;
CREATE SEQUENCE SGT_ALARM_SEQ	START 1;
CREATE SEQUENCE SGT_ALARM_ORDER_SEQ	START 1;


CREATE TABLE SGT_ACCOUNT (
    ACCOUNT_ID	VARCHAR PRIMARY KEY,
    PWD             	VARCHAR,
    FCM_TOKEN	VARCHAR,
    NICKNAME    VARCHAR,
    STAR_TYPE	VARCHAR,
    STAR_CNT        NUMERIC
);

CREATE TABLE SGT_MENU (
	MENU_ID 		NUMERIC PRIMARY KEY,
	IMAGE			VARCHAR,
	CATEGORY1		VARCHAR,
	CATEGORY2		VARCHAR,
	MENU_NAME		VARCHAR,
	MENU_NAME_ENG	VARCHAR,
	SIZE			VARCHAR,
	PRICE			NUMERIC
);

CREATE TABLE SGT_PRIVATE_MENU (
	PRIVATE_MENU_ID	NUMERIC PRIMARY KEY,
	CUP				VARCHAR,
	ACCOUNT_ID		VARCHAR REFERENCES SGT_ACCOUNT(ACCOUNT_ID) ON DELETE CASCADE,
	MENU_ID			NUMERIC REFERENCES SGT_MENU(MENU_ID) ON DELETE CASCADE,
	SHOT			NUMERIC,
	SYRUP			NUMERIC,
	WHIPPED_CREAM	BOOLEAN,
	DRIZZLE			BOOLEAN,
	SIZE			VARCHAR,
	OPTION_SUM		NUMERIC,
	PRICE			NUMERIC
);

CREATE TABLE SGT_TUMBLER (
	TUMBLER_ID			NUMERIC PRIMARY KEY,
	IMAGE				VARCHAR NOT NULL,
	NFC_ID				VARCHAR UNIQUE,
	ACCOUNT_ID 			VARCHAR REFERENCES SGT_ACCOUNT(ACCOUNT_ID) ON DELETE CASCADE,
	TUMBLER_NAME		VARCHAR,
	TUMBLER_PIN			VARCHAR UNIQUE,
	SIZE				VARCHAR DEFAULT 1,--Q
	TUMBLER_MONEY		NUMERIC DEFAULT 0,
	GREEN_SEED			NUMERIC DEFAULT 0,
	LOST_YN				BOOLEAN DEFAULT FALSE,
	PAY_YN				BOOLEAN DEFAULT TRUE,
	PRIVATE_MENU_ID		NUMERIC REFERENCES SGT_PRIVATE_MENU(PRIVATE_MENU_ID) ON DELETE CASCADE
);



CREATE TABLE SGT_ORDER (
	ORDER_ID 		NUMERIC PRIMARY KEY,
	ACCOUNT_ID		VARCHAR REFERENCES SGT_ACCOUNT(ACCOUNT_ID) ON DELETE CASCADE,
	ORDER_TIME		TIMESTAMP	NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRICE			NUMERIC,
	STORE_NAME		VARCHAR DEFAULT '남산스테이트점',
	TUMBLER_ID		NUMERIC REFERENCES SGT_TUMBLER(TUMBLER_ID) ON DELETE CASCADE
);

CREATE TABLE SGT_ORDERDETAILS (
	ORDER_ID		NUMERIC NOT NULL REFERENCES SGT_ORDER(ORDER_ID) ON DELETE CASCADE,
	LINE_ID			NUMERIC,
	PRIVATE_MENU_YN	BOOLEAN,
	PRIVATE_MENU_ID NUMERIC REFERENCES SGT_PRIVATE_MENU(PRIVATE_MENU_ID) ON DELETE CASCADE,
	MENU_ID			NUMERIC REFERENCES SGT_MENU(MENU_ID) ON DELETE CASCADE,
	IS_TUMBLER		BOOLEAN,
	SHOT			NUMERIC DEFAULT 0,
	SYRUP			NUMERIC DEFAULT 0,
	WHIPPED_CREAM		BOOLEAN DEFAULT FALSE,
	DRIZZLE			BOOLEAN DEFAULT FALSE,
	SIZE			VARCHAR,
	OPTION_SUM		NUMERIC DEFAULT 0,
	MENU_CNT		NUMERIC DEFAULT 1,
	PRICE			NUMERIC,

	CONSTRAINT PF PRIMARY KEY (ORDER_ID, LINE_ID)
);

CREATE TABLE SGT_ALARM (
	ALARM_ID	NUMERIC PRIMARY KEY,
	MSG			VARCHAR,
	ACCOUNT_ID	VARCHAR REFERENCES SGT_ACCOUNT(ACCOUNT_ID) NOT NULL,
	ALARM_TYPE	VARCHAR NOT NULL, -- 'pay', 'lost', 'charge',
	ALARM_TIME  TIMESTAMP	NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE SGT_ALARM_ORDER (
	ALARM_ORDER_ID 	NUMERIC PRIMARY KEY,
	ALARM_ID		NUMERIC REFERENCES SGT_ALARM(ALARM_ID) NOT NULL,
	ORDER_ID		NUMERIC REFERENCES SGT_ORDER(ORDER_ID) NOT NULL
);

-- 유저_텀블러 : 유저의 메인 텀블러
CREATE TABLE SGT_ACCOUNT_TUMBLER(
	ACCOUNT_ID		VARCHAR NOT NULL,
	TUMBLER_ID		NUMERIC NOT NULL,
	PRIMARY KEY (ACCOUNT_ID),
	FOREIGN KEY (ACCOUNT_ID) REFERENCES SGT_ACCOUNT(ACCOUNT_ID),
	FOREIGN KEY (TUMBLER_ID) REFERENCES SGT_TUMBLER(TUMBLER_ID)
);


-- USER DUMMY

INSERT INTO SGT_ACCOUNT (ACCOUNT_ID, PWD, FCM_TOKEN, NICKNAME, STAR_TYPE, STAR_CNT)
VALUES ( 'hojun', 'hojun', 'c1pS4pl2S54:APA91bFKIL6CaBEInIraBDz-bmT0AvG4StHfHnRkyZuZBXzqOHBXigSw6-4cSaG52puZtJGSPa_jzPk2ce2h4-B_ZK76Xk3cWtMrh3unPludjFHtkBo6SGWSfmeS4dDwZviLot6ulWac', '붓싼싸나이', 'gold', 10);
INSERT INTO SGT_ACCOUNT (ACCOUNT_ID, PWD, FCM_TOKEN, NICKNAME, STAR_TYPE, STAR_CNT)
VALUES ( 'hanbe', 'hanbe', 'c1pS4pl2S54:APA91bFKIL6CaBEInIraBDz-bmT0AvG4StHfHnRkyZuZBXzqOHBXigSw6-4cSaG52puZtJGSPa_jzPk2ce2h4-B_ZK76Xk3cWtMrh3unPludjFHtkBo6SGWSfmeS4dDwZviLot6ulWac' ,'김한배', 'gold', 10);
INSERT INTO SGT_ACCOUNT (ACCOUNT_ID, PWD, FCM_TOKEN, NICKNAME, STAR_TYPE, STAR_CNT)
VALUES ( 'eunkyoung', 'eunkyoung', 'c1pS4pl2S54:APA91bFKIL6CaBEInIraBDz-bmT0AvG4StHfHnRkyZuZBXzqOHBXigSw6-4cSaG52puZtJGSPa_jzPk2ce2h4-B_ZK76Xk3cWtMrh3unPludjFHtkBo6SGWSfmeS4dDwZviLot6ulWac' ,'오은경', 'gold', 10);
INSERT INTO SGT_ACCOUNT (ACCOUNT_ID, PWD, FCM_TOKEN, NICKNAME, STAR_TYPE, STAR_CNT)
VALUES ( 'sanghyeon', 'sanghyeon', 'c1pS4pl2S54:APA91bFKIL6CaBEInIraBDz-bmT0AvG4StHfHnRkyZuZBXzqOHBXigSw6-4cSaG52puZtJGSPa_jzPk2ce2h4-B_ZK76Xk3cWtMrh3unPludjFHtkBo6SGWSfmeS4dDwZviLot6ulWac' ,'안상현', 'gold', 10);
INSERT INTO SGT_ACCOUNT (ACCOUNT_ID, PWD, FCM_TOKEN, NICKNAME, STAR_TYPE, STAR_CNT)
VALUES ( 'heejae', 'heejae', 'dT-0Gwwyli8:APA91bFwnLd-Ms4YQj5CFZxn_ey2P2BYniVMjPLrqoIx2cbPSpgCdrH0Bh3rwOvB-sgVZ1IRflcFGijdo0VZQGVgLjo6e1cUtPMHMDrLUWxP9wxhtiCnisuDVECbgWLBKDt34sR2zX6e' ,'김희재', 'gold', 10);
INSERT INTO SGT_ACCOUNT (ACCOUNT_ID, PWD, FCM_TOKEN, NICKNAME, STAR_TYPE, STAR_CNT)
VALUES ( 'ujeong', 'ujeong', 'c1pS4pl2S54:APA91bFKIL6CaBEInIraBDz-bmT0AvG4StHfHnRkyZuZBXzqOHBXigSw6-4cSaG52puZtJGSPa_jzPk2ce2h4-B_ZK76Xk3cWtMrh3unPludjFHtkBo6SGWSfmeS4dDwZviLot6ulWac' ,'이유정', 'gold', 10);
INSERT INTO SGT_ACCOUNT (ACCOUNT_ID, PWD, FCM_TOKEN, NICKNAME, STAR_TYPE, STAR_CNT)
VALUES ( 'test', 'test', 'c1pS4pl2S54:APA91bFKIL6CaBEInIraBDz-bmT0AvG4StHfHnRkyZuZBXzqOHBXigSw6-4cSaG52puZtJGSPa_jzPk2ce2h4-B_ZK76Xk3cWtMrh3unPludjFHtkBo6SGWSfmeS4dDwZviLot6ulWac' ,'test', 'gold', 10);

-- TUMBLER DUMMY
INSERT INTO SGT_TUMBLER (TUMBLER_ID, IMAGE, NFC_ID, ACCOUNT_ID, TUMBLER_NAME, TUMBLER_PIN, GREEN_SEED, TUMBLER_MONEY)
VALUES ( NEXTVAL('SGT_TUMBLER_SEQ'), 'https://green-tumbler-server-s3.s3.ap-northeast-2.amazonaws.com/tumblers/marvel_white.png','0012649608', 'hojun', 'hojun의 텀블러', '0002360456', 149, 10000);
--INSERT INTO SGT_TUMBLER (TUMBLER_ID, IMAGE, NFC_ID, ACCOUNT_ID, TUMBLER_NAME, TUMBLER_PIN, GREEN_SEED, TUMBLER_MONEY)	
--VALUES ( NEXTVAL('SGT_TUMBLER_SEQ'), 'https://green-tumbler-server-s3.s3.ap-northeast-2.amazonaws.com/tumblers/reserve_white.png','0013304968', 'hanbe', '한배의 텀블러', '0013304968', 148, 10000);
INSERT INTO SGT_TUMBLER (TUMBLER_ID, IMAGE, NFC_ID, ACCOUNT_ID, TUMBLER_NAME, TUMBLER_PIN, GREEN_SEED, TUMBLER_MONEY)
VALUES ( NEXTVAL('SGT_TUMBLER_SEQ'), 'https://green-tumbler-server-s3.s3.ap-northeast-2.amazonaws.com/tumblers/marvel_white.png','0013304968', NULL, NULL, '0013304968', 148, 10000);
INSERT INTO SGT_TUMBLER (TUMBLER_ID, IMAGE, NFC_ID, ACCOUNT_ID, TUMBLER_NAME, TUMBLER_PIN, GREEN_SEED, TUMBLER_MONEY)
VALUES ( NEXTVAL('SGT_TUMBLER_SEQ'), 'https://green-tumbler-server-s3.s3.ap-northeast-2.amazonaws.com/tumblers/holiday_coldcup.png','0014222472', 'eunkyoung', 'eunkyoung의 텀블러', '0014222472', 148, 10000);
INSERT INTO SGT_TUMBLER (TUMBLER_ID, IMAGE, NFC_ID, ACCOUNT_ID, TUMBLER_NAME, TUMBLER_PIN, GREEN_SEED, TUMBLER_MONEY)
VALUES ( NEXTVAL('SGT_TUMBLER_SEQ'), 'https://green-tumbler-server-s3.s3.ap-northeast-2.amazonaws.com/tumblers/spring_coldcup.png','0014877832', 'sanghyeon', 'sanghyeon의 텀블러', '0014877832', 148, 10000);
INSERT INTO SGT_TUMBLER (TUMBLER_ID, IMAGE, NFC_ID, ACCOUNT_ID, TUMBLER_NAME, TUMBLER_PIN, GREEN_SEED, TUMBLER_MONEY)
VALUES ( NEXTVAL('SGT_TUMBLER_SEQ'), 'https://green-tumbler-server-s3.s3.ap-northeast-2.amazonaws.com/tumblers/spring_coldcup.png','0015598728', 'ujeong', 'ujeong의 텀블러', '0015598728', 148, 10000);
INSERT INTO SGT_TUMBLER (TUMBLER_ID, IMAGE, NFC_ID, ACCOUNT_ID, TUMBLER_NAME, TUMBLER_PIN, LOST_YN, PAY_YN, GREEN_SEED, TUMBLER_MONEY)
VALUES ( NEXTVAL('SGT_TUMBLER_SEQ'), 'https://green-tumbler-server-s3.s3.ap-northeast-2.amazonaws.com/tumblers/marvel_white.png', '0016188552', 'heejae', 'heejae의 텀블러', '0016188552', TRUE, FALSE, 148, 10000);
INSERT INTO SGT_TUMBLER (TUMBLER_ID, IMAGE, NFC_ID, ACCOUNT_ID, TUMBLER_NAME, TUMBLER_PIN, GREEN_SEED, TUMBLER_MONEY)
VALUES ( NEXTVAL('SGT_TUMBLER_SEQ'), 'https://green-tumbler-server-s3.s3.ap-northeast-2.amazonaws.com/tumblers/spring_coldcup.png', '0000197768', NULL, NULL, '0000197768', 148, 10000);



-- USER_TUMBLER DUMMY (주 사용 텀블러 지정)
INSERT INTO SGT_ACCOUNT_TUMBLER (ACCOUNT_ID, TUMBLER_ID)
VALUES ('hojun', 1);
INSERT INTO SGT_ACCOUNT_TUMBLER (ACCOUNT_ID, TUMBLER_ID)
VALUES ('hanbe', 2);
INSERT INTO SGT_ACCOUNT_TUMBLER (ACCOUNT_ID, TUMBLER_ID)
VALUES ('eunkyoung', 3);
INSERT INTO SGT_ACCOUNT_TUMBLER (ACCOUNT_ID, TUMBLER_ID)
VALUES ('sanghyeon', 4);
INSERT INTO SGT_ACCOUNT_TUMBLER (ACCOUNT_ID, TUMBLER_ID)
VALUES ('ujeong', 5);
INSERT INTO SGT_ACCOUNT_TUMBLER (ACCOUNT_ID, TUMBLER_ID)
VALUES ('heejae', 6);

-- ALARM
INSERT INTO SGT_ALARM (ALARM_ID, MSG, ACCOUNT_ID, ALARM_TYPE)
VALUES (NEXTVAL('SGT_ALARM_SEQ'), '결제 완료 되었습니다.', 'hojun', 'pay');
INSERT INTO SGT_ALARM (ALARM_ID, MSG, ACCOUNT_ID, ALARM_TYPE)
VALUES (NEXTVAL('SGT_ALARM_SEQ'), '결제 완료 되었습니다.', 'hanbe', 'pay');
INSERT INTO SGT_ALARM (ALARM_ID, MSG, ACCOUNT_ID, ALARM_TYPE)
VALUES (NEXTVAL('SGT_ALARM_SEQ'), '결제 완료 되었습니다.', 'eunkyoung', 'pay');
INSERT INTO SGT_ALARM (ALARM_ID, MSG, ACCOUNT_ID, ALARM_TYPE)
VALUES (NEXTVAL('SGT_ALARM_SEQ'), '결제 완료 되었습니다.', 'sanghyeon', 'pay');
INSERT INTO SGT_ALARM (ALARM_ID, MSG, ACCOUNT_ID, ALARM_TYPE)
VALUES (NEXTVAL('SGT_ALARM_SEQ'), '결제 완료 되었습니다.', 'ujeong', 'pay');
INSERT INTO SGT_ALARM (ALARM_ID, MSG, ACCOUNT_ID, ALARM_TYPE)
VALUES (NEXTVAL('SGT_ALARM_SEQ'), '결제 완료 되었습니다.', 'heejae', 'pay');

INSERT INTO SGT_ALARM (ALARM_ID, MSG, ACCOUNT_ID, ALARM_TYPE)
VALUES (NEXTVAL('SGT_ALARM_SEQ'), 'hojun의 텀블러에 10000원 충전되었습니다.', 'hojun', 'charge');
INSERT INTO SGT_ALARM (ALARM_ID, MSG, ACCOUNT_ID, ALARM_TYPE)
VALUES (NEXTVAL('SGT_ALARM_SEQ'), 'hanbe의 텀블러에 10000원 충전되었습니다.', 'hanbe', 'charge');
INSERT INTO SGT_ALARM (ALARM_ID, MSG, ACCOUNT_ID, ALARM_TYPE)
VALUES (NEXTVAL('SGT_ALARM_SEQ'), 'eunkyoung의 텀블러에 10000원 충전되었습니다.', 'eunkyoung', 'charge');
INSERT INTO SGT_ALARM (ALARM_ID, MSG, ACCOUNT_ID, ALARM_TYPE)
VALUES (NEXTVAL('SGT_ALARM_SEQ'), 'sanghyeon의 텀블러에 10000원 충전되었습니다.', 'sanghyeon', 'charge');
INSERT INTO SGT_ALARM (ALARM_ID, MSG, ACCOUNT_ID, ALARM_TYPE)
VALUES (NEXTVAL('SGT_ALARM_SEQ'), 'ujeong의 텀블러에 10000원 충전되었습니다.', 'ujeong', 'charge');
INSERT INTO SGT_ALARM (ALARM_ID, MSG, ACCOUNT_ID, ALARM_TYPE)
VALUES (NEXTVAL('SGT_ALARM_SEQ'), 'heejae의 텀블러에 10000원 충전되었습니다.', 'heejae', 'charge');

INSERT INTO SGT_ALARM (ALARM_ID, MSG, ACCOUNT_ID, ALARM_TYPE)
VALUES (NEXTVAL('SGT_ALARM_SEQ'), '분실 신고 되었습니다.', 'heejae', 'lost');

-- MENU DUMMY
-- ESPRESSO
INSERT INTO SGT_MENU (MENU_ID, IMAGE, CATEGORY1, CATEGORY2, MENU_NAME, MENU_NAME_ENG, SIZE, PRICE)
VALUES (NEXTVAL('SGT_MENU_SEQ'), 'https://green-tumbler-server-s3.s3.ap-northeast-2.amazonaws.com/menus/ice_americano.jpg', '음료', '에스프레소', '아이스 카페 아메리카노', 'Iced Caffe Americano', 1, 4100);

INSERT INTO SGT_MENU (MENU_ID, IMAGE, CATEGORY1, CATEGORY2, MENU_NAME, MENU_NAME_ENG, SIZE, PRICE)
VALUES (NEXTVAL('SGT_MENU_SEQ'), 'https://green-tumbler-server-s3.s3.ap-northeast-2.amazonaws.com/menus/espresso.jpg', '음료', '에스프레소', '에스프레소', 'Espresso', 1, 3600);

INSERT INTO SGT_MENU (MENU_ID, IMAGE, CATEGORY1, CATEGORY2, MENU_NAME, MENU_NAME_ENG, SIZE, PRICE)
VALUES (NEXTVAL('SGT_MENU_SEQ'), 'https://green-tumbler-server-s3.s3.ap-northeast-2.amazonaws.com/menus/ice_cafe_moca.jpg', '음료', '에스프레소', '아이스 카페모카', 'Iced Caffe Mocha', 1, 5100 );

INSERT INTO SGT_MENU (MENU_ID, IMAGE, CATEGORY1, CATEGORY2, MENU_NAME, MENU_NAME_ENG, SIZE, PRICE)
VALUES (NEXTVAL('SGT_MENU_SEQ'), 'https://green-tumbler-server-s3.s3.ap-northeast-2.amazonaws.com/menus/ice_cafe_latte.jpg', '음료', '에스프레소', '아이스 카페라떼', 'Iced Caffe Latte', 1, 4600);

INSERT INTO SGT_MENU (MENU_ID, IMAGE, CATEGORY1, CATEGORY2, MENU_NAME, MENU_NAME_ENG, SIZE, PRICE)
VALUES (NEXTVAL('SGT_MENU_SEQ'), 'https://green-tumbler-server-s3.s3.ap-northeast-2.amazonaws.com/menus/ice_cappucino.jpg', '음료', '에스프레소', '아이스 카푸치노', 'Iced Cappuccino', 1, 4600);

INSERT INTO SGT_MENU (MENU_ID, IMAGE, CATEGORY1, CATEGORY2, MENU_NAME, MENU_NAME_ENG, SIZE, PRICE)
VALUES (NEXTVAL('SGT_MENU_SEQ'), 'https://green-tumbler-server-s3.s3.ap-northeast-2.amazonaws.com/menus/dolce_latte.jpg', '음료', '에스프레소', '돌체 콜드 브루', 'Dolce Cold Brew', 1, 5600);

-- 프라푸치노
INSERT INTO SGT_MENU (MENU_ID, IMAGE, CATEGORY1, CATEGORY2, MENU_NAME, MENU_NAME_ENG, SIZE, PRICE)
VALUES (NEXTVAL('SGT_MENU_SEQ'), 'https://green-tumbler-server-s3.s3.ap-northeast-2.amazonaws.com/menus/moca_prafuccino.jpg', '음료', '프라푸치노', '모카 프라푸치노', 'Mocha Frappuccino', 1, 5600);

INSERT INTO SGT_MENU (MENU_ID, IMAGE, CATEGORY1, CATEGORY2, MENU_NAME, MENU_NAME_ENG, SIZE, PRICE)
VALUES (NEXTVAL('SGT_MENU_SEQ'), 'https://green-tumbler-server-s3.s3.ap-northeast-2.amazonaws.com/menus/amond_moca_prafuccino.jpg', '음료', '프라푸치노', '아몬드 모카 프라푸치노', 'Almond Mocha Frappuccino', 1, 6300);

INSERT INTO SGT_MENU (MENU_ID, IMAGE, CATEGORY1, CATEGORY2, MENU_NAME, MENU_NAME_ENG, SIZE, PRICE)
VALUES (NEXTVAL('SGT_MENU_SEQ'), 'https://green-tumbler-server-s3.s3.ap-northeast-2.amazonaws.com/menus/espresso_prafuccino.jpg', '음료', '프라푸치노', '에스프레소 프라푸치노', 'Espresso Frappuccino', 1, 5100);

INSERT INTO SGT_MENU (MENU_ID, IMAGE, CATEGORY1, CATEGORY2, MENU_NAME, MENU_NAME_ENG, SIZE, PRICE)
VALUES (NEXTVAL('SGT_MENU_SEQ'), 'https://green-tumbler-server-s3.s3.ap-northeast-2.amazonaws.com/menus/caramel_prafuccino.jpg', '음료', '프라푸치노', '카라멜 프라푸치노', 'Caramel Frappuccino', 1, 7200);

INSERT INTO SGT_MENU (MENU_ID, IMAGE, CATEGORY1, CATEGORY2, MENU_NAME, MENU_NAME_ENG, SIZE, PRICE)
VALUES (NEXTVAL('SGT_MENU_SEQ'), 'https://green-tumbler-server-s3.s3.ap-northeast-2.amazonaws.com/menus/vanilla_cream_praffucino.jpg', '음료', '프라푸치노', '바닐라 크림 프라푸치노', 'Vanilla Cream Frappuccino', 1, 4800);

-- 블랜디드
INSERT INTO SGT_MENU (MENU_ID, IMAGE, CATEGORY1, CATEGORY2, MENU_NAME, MENU_NAME_ENG, SIZE, PRICE)
VALUES (NEXTVAL('SGT_MENU_SEQ'), 'https://green-tumbler-server-s3.s3.ap-northeast-2.amazonaws.com/menus/decaffeine_apogatto_blended.jpg', '음료', '블렌디드', '디카페인 아포가토 블렌디드', 'Decaf Affogato Blended', 1, 6100);

INSERT INTO SGT_MENU (MENU_ID, IMAGE, CATEGORY1, CATEGORY2, MENU_NAME, MENU_NAME_ENG, SIZE, PRICE)
VALUES (NEXTVAL('SGT_MENU_SEQ'), 'https://green-tumbler-server-s3.s3.ap-northeast-2.amazonaws.com/menus/mango_fashion_fruits_blended.jpg', '음료', '블렌디드', '망고 패션 후르츠 블렌디드', 'Mango Passion Fruit Blended', 1, 5000);

INSERT INTO SGT_MENU (MENU_ID, IMAGE, CATEGORY1, CATEGORY2, MENU_NAME, MENU_NAME_ENG, SIZE, PRICE)
VALUES (NEXTVAL('SGT_MENU_SEQ'), 'https://green-tumbler-server-s3.s3.ap-northeast-2.amazonaws.com/menus/jeju_hodu_danggun_blended.jpg', '음료', '블렌디드', '제주 호두 당근 블랜디드', 'Jeju Walnut Carrot Blended', 1, 7200);

INSERT INTO SGT_MENU (MENU_ID, IMAGE, CATEGORY1, CATEGORY2, MENU_NAME, MENU_NAME_ENG, SIZE, PRICE)
VALUES (NEXTVAL('SGT_MENU_SEQ'), 'https://green-tumbler-server-s3.s3.ap-northeast-2.amazonaws.com/menus/ddalgi_yogurt_blended.jpg', '음료', '블렌디드', '딸기 요거트 블랜디드', 'Strawberry Yogurt Blended', 1, 6100);

INSERT INTO SGT_MENU (MENU_ID, IMAGE, CATEGORY1, CATEGORY2, MENU_NAME, MENU_NAME_ENG, SIZE, PRICE)
VALUES (NEXTVAL('SGT_MENU_SEQ'), 'https://green-tumbler-server-s3.s3.ap-northeast-2.amazonaws.com/menus/mango_banana_blended.jpg', '음료', '블렌디드', '망고 바나나 블랜디드', 'Mango Banana Blended', 1, 6300);

-- 피지오
INSERT INTO SGT_MENU (MENU_ID, IMAGE, CATEGORY1, CATEGORY2, MENU_NAME, MENU_NAME_ENG, SIZE, PRICE)
VALUES (NEXTVAL('SGT_MENU_SEQ'), 'https://green-tumbler-server-s3.s3.ap-northeast-2.amazonaws.com/menus/black_tea_lemonade_figio.jpg', '음료', '피지오', '블랙 티 레모네이드 피지오', 'Black Tea Lemonade Fizzio', 1, 5400);

INSERT INTO SGT_MENU (MENU_ID, IMAGE, CATEGORY1, CATEGORY2, MENU_NAME, MENU_NAME_ENG, SIZE, PRICE)
VALUES (NEXTVAL('SGT_MENU_SEQ'), 'https://green-tumbler-server-s3.s3.ap-northeast-2.amazonaws.com/menus/cool_lime_figio.jpg', '음료', '피지오', '쿨 라임 피지오', 'Cool Lime Starbucks Fizzio', 1, 5900);

INSERT INTO SGT_MENU (MENU_ID, IMAGE, CATEGORY1, CATEGORY2, MENU_NAME, MENU_NAME_ENG, SIZE, PRICE)
VALUES (NEXTVAL('SGT_MENU_SEQ'), 'https://green-tumbler-server-s3.s3.ap-northeast-2.amazonaws.com/menus/pink_jamong_figio.jpg', '음료', '피지오', '핑크 자몽 피지오', 'Pink Grapefruit Fizzio', 1, 6300);

INSERT INTO SGT_MENU (MENU_ID, IMAGE, CATEGORY1, CATEGORY2, MENU_NAME, MENU_NAME_ENG, SIZE, PRICE)
VALUES (NEXTVAL('SGT_MENU_SEQ'), 'https://green-tumbler-server-s3.s3.ap-northeast-2.amazonaws.com/menus/fashion_tango_tea_lemonade_figio.jpg', '음료', '피지오', '패션 탱고 레모네이드 피지오', 'Passion Tango Tea Lemonade Fizzio', 1, 5400);

-- 티
INSERT INTO SGT_MENU (MENU_ID, IMAGE, CATEGORY1, CATEGORY2, MENU_NAME, MENU_NAME_ENG, SIZE, PRICE)
VALUES (NEXTVAL('SGT_MENU_SEQ'), 'https://green-tumbler-server-s3.s3.ap-northeast-2.amazonaws.com/menus/malcha_lemonade.jpg', '음료', '티', '말차 레모네이드', 'Matcha Lemonade', 1, 6100);

INSERT INTO SGT_MENU (MENU_ID, IMAGE, CATEGORY1, CATEGORY2, MENU_NAME, MENU_NAME_ENG, SIZE, PRICE)
VALUES (NEXTVAL('SGT_MENU_SEQ'), 'https://green-tumbler-server-s3.s3.ap-northeast-2.amazonaws.com/menus/starbucks_ice_tea.jpg', '음료', '티', '별다방 아이스 티', 'Byuldabang Iced Tea', 1, 5600);

INSERT INTO SGT_MENU (MENU_ID, IMAGE, CATEGORY1, CATEGORY2, MENU_NAME, MENU_NAME_ENG, SIZE, PRICE)
VALUES (NEXTVAL('SGT_MENU_SEQ'), 'https://green-tumbler-server-s3.s3.ap-northeast-2.amazonaws.com/menus/pinkberry_youthberry.jpg', '음료', '티', '핑크베리 유스베리', 'Pinkberry Youthberry', 1, 6100);

INSERT INTO SGT_MENU (MENU_ID, IMAGE, CATEGORY1, CATEGORY2, MENU_NAME, MENU_NAME_ENG, SIZE, PRICE)
VALUES (NEXTVAL('SGT_MENU_SEQ'), 'https://green-tumbler-server-s3.s3.ap-northeast-2.amazonaws.com/menus/grandma_apple_black_tea.jpg', '음료', '티', '그랜마 애플 블랙 티', 'Grandma Apple Black Tea', 1, 7500);

INSERT INTO SGT_MENU (MENU_ID, IMAGE, CATEGORY1, CATEGORY2, MENU_NAME, MENU_NAME_ENG, SIZE, PRICE)
VALUES (NEXTVAL('SGT_MENU_SEQ'), 'https://green-tumbler-server-s3.s3.ap-northeast-2.amazonaws.com/menus/lime_fashion_tea.jpg', '음료', '티', '라임 패션 티', 'Lime Passion Tea', 1, 5600);

--주문정보(헤더)
INSERT INTO SGT_ORDER VALUES ( NEXTVAL('SGT_ORDER_SEQ'), 'hojun', DEFAULT, 14000, '남산스테이트점', 1 );
INSERT INTO SGT_ORDER VALUES ( NEXTVAL('SGT_ORDER_SEQ'), 'hojun', DEFAULT, 14600, '남산스테이트점', 1 );
INSERT INTO SGT_ORDER VALUES ( NEXTVAL('SGT_ORDER_SEQ'), 'hanbe', DEFAULT, 14000, '남산스테이트점', 1 );
INSERT INTO SGT_ORDER VALUES ( NEXTVAL('SGT_ORDER_SEQ'), 'hanbe', DEFAULT, 14600, '남산스테이트점', 1 );
INSERT INTO SGT_ORDER VALUES ( NEXTVAL('SGT_ORDER_SEQ'), 'eunkyoung', DEFAULT, 14000, '남산스테이트점', 1 );
INSERT INTO SGT_ORDER VALUES ( NEXTVAL('SGT_ORDER_SEQ'), 'eunkyoung', DEFAULT, 14600, '남산스테이트점', 1 );
INSERT INTO SGT_ORDER VALUES ( NEXTVAL('SGT_ORDER_SEQ'), 'sanghyeon', DEFAULT, 14000, '남산스테이트점', 1 );
INSERT INTO SGT_ORDER VALUES ( NEXTVAL('SGT_ORDER_SEQ'), 'sanghyeon', DEFAULT, 14600, '남산스테이트점', 1 );
INSERT INTO SGT_ORDER VALUES ( NEXTVAL('SGT_ORDER_SEQ'), 'ujeong', DEFAULT, 14000, '남산스테이트점', 1 );
INSERT INTO SGT_ORDER VALUES ( NEXTVAL('SGT_ORDER_SEQ'), 'ujeong', DEFAULT, 14600, '남산스테이트점', 1 );
INSERT INTO SGT_ORDER VALUES ( NEXTVAL('SGT_ORDER_SEQ'), 'heejae', DEFAULT, 14000, '남산스테이트점', 1 );
INSERT INTO SGT_ORDER VALUES ( NEXTVAL('SGT_ORDER_SEQ'), 'heejae', DEFAULT, 14600, '남산스테이트점', 1 );

--주문정보(디테일)
INSERT INTO SGT_ORDERDETAILS (ORDER_ID, LINE_ID, PRIVATE_MENU_YN, PRIVATE_MENU_ID, MENU_ID, IS_TUMBLER, SIZE, PRICE, SYRUP, SHOT, OPTION_SUM) 
VALUES ( 1, 1, FALSE, NULL, 24, TRUE, 'T', 9300, 1, 2, 1800);
INSERT INTO SGT_ORDERDETAILS (ORDER_ID, LINE_ID, PRIVATE_MENU_YN, PRIVATE_MENU_ID, MENU_ID, IS_TUMBLER, SIZE, PRICE, SYRUP, SHOT, OPTION_SUM) 
VALUES ( 1, 2, FALSE, NULL, 1, TRUE, 'T', 4700, 1, 0, 600);
INSERT INTO SGT_ORDERDETAILS (ORDER_ID, LINE_ID, PRIVATE_MENU_YN, PRIVATE_MENU_ID, MENU_ID, IS_TUMBLER, SIZE, PRICE, SYRUP, SHOT, OPTION_SUM) 
VALUES ( 2, 1, FALSE, NULL, 24, TRUE, 'T', 9300, 1, 2, 1800);
INSERT INTO SGT_ORDERDETAILS (ORDER_ID, LINE_ID, PRIVATE_MENU_YN, PRIVATE_MENU_ID, MENU_ID, IS_TUMBLER, SIZE, PRICE, SYRUP, SHOT, OPTION_SUM) 
VALUES ( 2, 2, FALSE, NULL, 1, TRUE, 'T', 5300, 2, 0, 600);

INSERT INTO SGT_ORDERDETAILS (ORDER_ID, LINE_ID, PRIVATE_MENU_YN, PRIVATE_MENU_ID, MENU_ID, IS_TUMBLER, SIZE, PRICE, SYRUP, SHOT, OPTION_SUM) 
VALUES ( 3, 1, FALSE, NULL, 24, TRUE, 'T', 9300, 1, 2, 1800);
INSERT INTO SGT_ORDERDETAILS (ORDER_ID, LINE_ID, PRIVATE_MENU_YN, PRIVATE_MENU_ID, MENU_ID, IS_TUMBLER, SIZE, PRICE, SYRUP, SHOT, OPTION_SUM) 
VALUES ( 3, 2, FALSE, NULL, 1, TRUE, 'T', 4700, 1, 0, 600);
INSERT INTO SGT_ORDERDETAILS (ORDER_ID, LINE_ID, PRIVATE_MENU_YN, PRIVATE_MENU_ID, MENU_ID, IS_TUMBLER, SIZE, PRICE, SYRUP, SHOT, OPTION_SUM) 
VALUES ( 4, 1, FALSE, NULL, 24, TRUE, 'T', 9300, 1, 2, 1800);
INSERT INTO SGT_ORDERDETAILS (ORDER_ID, LINE_ID, PRIVATE_MENU_YN, PRIVATE_MENU_ID, MENU_ID, IS_TUMBLER, SIZE, PRICE, SYRUP, SHOT, OPTION_SUM) 
VALUES ( 4, 2, FALSE, NULL, 1, TRUE, 'T', 5300, 2, 0, 600);

INSERT INTO SGT_ORDERDETAILS (ORDER_ID, LINE_ID, PRIVATE_MENU_YN, PRIVATE_MENU_ID, MENU_ID, IS_TUMBLER, SIZE, PRICE, SYRUP, SHOT, OPTION_SUM) 
VALUES ( 5, 1, FALSE, NULL, 24, TRUE, 'T', 9300, 1, 2, 1800);
INSERT INTO SGT_ORDERDETAILS (ORDER_ID, LINE_ID, PRIVATE_MENU_YN, PRIVATE_MENU_ID, MENU_ID, IS_TUMBLER, SIZE, PRICE, SYRUP, SHOT, OPTION_SUM) 
VALUES ( 5, 2, FALSE, NULL, 1, TRUE, 'T', 5300, 2, 0, 600);
INSERT INTO SGT_ORDERDETAILS (ORDER_ID, LINE_ID, PRIVATE_MENU_YN, PRIVATE_MENU_ID, MENU_ID, IS_TUMBLER, SIZE, PRICE, SYRUP, SHOT, OPTION_SUM) 
VALUES ( 6, 1, FALSE, NULL, 24, TRUE, 'T', 9300, 1, 2, 1800);
INSERT INTO SGT_ORDERDETAILS (ORDER_ID, LINE_ID, PRIVATE_MENU_YN, PRIVATE_MENU_ID, MENU_ID, IS_TUMBLER, SIZE, PRICE, SYRUP, SHOT, OPTION_SUM) 
VALUES ( 6, 2, FALSE, NULL, 1, TRUE, 'T', 5300, 2, 0, 600);

INSERT INTO SGT_ORDERDETAILS (ORDER_ID, LINE_ID, PRIVATE_MENU_YN, PRIVATE_MENU_ID, MENU_ID, IS_TUMBLER, SIZE, PRICE, SYRUP, SHOT, OPTION_SUM) 
VALUES ( 7, 1, FALSE, NULL, 24, TRUE, 'T', 9300, 1, 2, 1800);
INSERT INTO SGT_ORDERDETAILS (ORDER_ID, LINE_ID, PRIVATE_MENU_YN, PRIVATE_MENU_ID, MENU_ID, IS_TUMBLER, SIZE, PRICE, SYRUP, SHOT, OPTION_SUM) 
VALUES ( 7, 2, FALSE, NULL, 1, TRUE, 'T', 5300, 2, 0, 600);
INSERT INTO SGT_ORDERDETAILS (ORDER_ID, LINE_ID, PRIVATE_MENU_YN, PRIVATE_MENU_ID, MENU_ID, IS_TUMBLER, SIZE, PRICE, SYRUP, SHOT, OPTION_SUM) 
VALUES ( 8, 1, FALSE, NULL, 24, TRUE, 'T', 9300, 1, 2, 1800);
INSERT INTO SGT_ORDERDETAILS (ORDER_ID, LINE_ID, PRIVATE_MENU_YN, PRIVATE_MENU_ID, MENU_ID, IS_TUMBLER, SIZE, PRICE, SYRUP, SHOT, OPTION_SUM) 
VALUES ( 8, 2, FALSE, NULL, 1, TRUE, 'T', 5300, 2, 0, 600);

INSERT INTO SGT_ORDERDETAILS (ORDER_ID, LINE_ID, PRIVATE_MENU_YN, PRIVATE_MENU_ID, MENU_ID, IS_TUMBLER, SIZE, PRICE, SYRUP, SHOT, OPTION_SUM) 
VALUES ( 9, 1, FALSE, NULL, 24, TRUE, 'T', 9300, 1, 2, 1800);
INSERT INTO SGT_ORDERDETAILS (ORDER_ID, LINE_ID, PRIVATE_MENU_YN, PRIVATE_MENU_ID, MENU_ID, IS_TUMBLER, SIZE, PRICE, SYRUP, SHOT, OPTION_SUM) 
VALUES ( 9, 2, FALSE, NULL, 1, TRUE, 'T', 5300, 2, 0, 600);
INSERT INTO SGT_ORDERDETAILS (ORDER_ID, LINE_ID, PRIVATE_MENU_YN, PRIVATE_MENU_ID, MENU_ID, IS_TUMBLER, SIZE, PRICE, SYRUP, SHOT, OPTION_SUM) 
VALUES ( 10, 1, FALSE, NULL, 24, TRUE, 'T', 9300, 1, 2, 1800);
INSERT INTO SGT_ORDERDETAILS (ORDER_ID, LINE_ID, PRIVATE_MENU_YN, PRIVATE_MENU_ID, MENU_ID, IS_TUMBLER, SIZE, PRICE, SYRUP, SHOT, OPTION_SUM) 
VALUES ( 10, 2, FALSE, NULL, 1, TRUE, 'T', 5300, 2, 0, 600);

INSERT INTO SGT_ORDERDETAILS (ORDER_ID, LINE_ID, PRIVATE_MENU_YN, PRIVATE_MENU_ID, MENU_ID, IS_TUMBLER, SIZE, PRICE, SYRUP, SHOT, OPTION_SUM) 
VALUES ( 11, 1, FALSE, NULL, 24, TRUE, 'T', 9300, 1, 2, 1800);
INSERT INTO SGT_ORDERDETAILS (ORDER_ID, LINE_ID, PRIVATE_MENU_YN, PRIVATE_MENU_ID, MENU_ID, IS_TUMBLER, SIZE, PRICE, SYRUP, SHOT, OPTION_SUM) 
VALUES ( 11, 2, FALSE, NULL, 1, TRUE, 'T', 5300, 2, 0, 600);
INSERT INTO SGT_ORDERDETAILS (ORDER_ID, LINE_ID, PRIVATE_MENU_YN, PRIVATE_MENU_ID, MENU_ID, IS_TUMBLER, SIZE, PRICE, SYRUP, SHOT, OPTION_SUM) 
VALUES ( 12, 1, FALSE, NULL, 24, TRUE, 'T', 9300, 1, 2, 1800);
INSERT INTO SGT_ORDERDETAILS (ORDER_ID, LINE_ID, PRIVATE_MENU_YN, PRIVATE_MENU_ID, MENU_ID, IS_TUMBLER, SIZE, PRICE, SYRUP, SHOT, OPTION_SUM) 
VALUES ( 12, 2, FALSE, NULL, 1, TRUE, 'T', 5300, 2, 0, 600);

-- ALARM_ORDER
INSERT INTO SGT_ALARM_ORDER (ALARM_ORDER_ID, ALARM_ID, ORDER_ID)
VALUES	(NEXTVAL('SGT_ALARM_ORDER_SEQ'), 1, 1);
INSERT INTO SGT_ALARM_ORDER (ALARM_ORDER_ID, ALARM_ID, ORDER_ID)
VALUES	(NEXTVAL('SGT_ALARM_ORDER_SEQ'), 1, 2);
INSERT INTO SGT_ALARM_ORDER (ALARM_ORDER_ID, ALARM_ID, ORDER_ID)
VALUES	(NEXTVAL('SGT_ALARM_ORDER_SEQ'), 2, 3);
INSERT INTO SGT_ALARM_ORDER (ALARM_ORDER_ID, ALARM_ID, ORDER_ID)
VALUES	(NEXTVAL('SGT_ALARM_ORDER_SEQ'), 2, 4);
INSERT INTO SGT_ALARM_ORDER (ALARM_ORDER_ID, ALARM_ID, ORDER_ID)
VALUES	(NEXTVAL('SGT_ALARM_ORDER_SEQ'), 3, 5);
INSERT INTO SGT_ALARM_ORDER (ALARM_ORDER_ID, ALARM_ID, ORDER_ID)
VALUES	(NEXTVAL('SGT_ALARM_ORDER_SEQ'), 3, 6);
INSERT INTO SGT_ALARM_ORDER (ALARM_ORDER_ID, ALARM_ID, ORDER_ID)
VALUES	(NEXTVAL('SGT_ALARM_ORDER_SEQ'), 4, 7);
INSERT INTO SGT_ALARM_ORDER (ALARM_ORDER_ID, ALARM_ID, ORDER_ID)
VALUES	(NEXTVAL('SGT_ALARM_ORDER_SEQ'), 4, 8);
INSERT INTO SGT_ALARM_ORDER (ALARM_ORDER_ID, ALARM_ID, ORDER_ID)
VALUES	(NEXTVAL('SGT_ALARM_ORDER_SEQ'), 5, 9);
INSERT INTO SGT_ALARM_ORDER (ALARM_ORDER_ID, ALARM_ID, ORDER_ID)
VALUES	(NEXTVAL('SGT_ALARM_ORDER_SEQ'), 5, 10);
INSERT INTO SGT_ALARM_ORDER (ALARM_ORDER_ID, ALARM_ID, ORDER_ID)
VALUES	(NEXTVAL('SGT_ALARM_ORDER_SEQ'), 6, 11);
INSERT INTO SGT_ALARM_ORDER (ALARM_ORDER_ID, ALARM_ID, ORDER_ID)
VALUES	(NEXTVAL('SGT_ALARM_ORDER_SEQ'), 6, 12);

--나만의 메뉴
INSERT INTO SGT_PRIVATE_MENU 
(PRIVATE_MENU_ID, CUP, ACCOUNT_ID, MENU_ID, SHOT, SYRUP, WHIPPED_CREAM, DRIZZLE, SIZE, OPTION_SUM, PRICE)
VALUES
(NEXTVAL('SGT_PRIVATE_MENU_SEQ'), 'T', 'hojun', 2, 1, 1, false, false, 'T', 1200, 5300);
INSERT INTO SGT_PRIVATE_MENU 
(PRIVATE_MENU_ID, CUP, ACCOUNT_ID, MENU_ID, SHOT, SYRUP, WHIPPED_CREAM, DRIZZLE, SIZE, OPTION_SUM, PRICE)
VALUES
(NEXTVAL('SGT_PRIVATE_MENU_SEQ'), 'T', 'hojun', 7, 0, 1, true, false, 'G', 1200, 6800);

INSERT INTO SGT_PRIVATE_MENU 
(PRIVATE_MENU_ID, CUP, ACCOUNT_ID, MENU_ID, SHOT, SYRUP, WHIPPED_CREAM, DRIZZLE, SIZE, OPTION_SUM, PRICE)
VALUES
(NEXTVAL('SGT_PRIVATE_MENU_SEQ'), 'T', 'hanbe', 6, 1, 1, false, false, 'T', 1200, 6800);
INSERT INTO SGT_PRIVATE_MENU 
(PRIVATE_MENU_ID, CUP, ACCOUNT_ID, MENU_ID, SHOT, SYRUP, WHIPPED_CREAM, DRIZZLE, SIZE, OPTION_SUM, PRICE)
VALUES
(NEXTVAL('SGT_PRIVATE_MENU_SEQ'), 'T', 'hanbe', 24, 0, 1, true, false, 'G', 1200, 8700);

INSERT INTO SGT_PRIVATE_MENU 
(PRIVATE_MENU_ID, CUP, ACCOUNT_ID, MENU_ID, SHOT, SYRUP, WHIPPED_CREAM, DRIZZLE, SIZE, OPTION_SUM, PRICE)
VALUES
(NEXTVAL('SGT_PRIVATE_MENU_SEQ'), 'T', 'eunkyoung', 21, 1, 1, false, false, 'T', 1200, 7300);
INSERT INTO SGT_PRIVATE_MENU 
(PRIVATE_MENU_ID, CUP, ACCOUNT_ID, MENU_ID, SHOT, SYRUP, WHIPPED_CREAM, DRIZZLE, SIZE, OPTION_SUM, PRICE)
VALUES
(NEXTVAL('SGT_PRIVATE_MENU_SEQ'), 'T', 'eunkyoung', 14, 0, 1, true, false, 'G', 1200, 8400);

INSERT INTO SGT_PRIVATE_MENU 
(PRIVATE_MENU_ID, CUP, ACCOUNT_ID, MENU_ID, SHOT, SYRUP, WHIPPED_CREAM, DRIZZLE, SIZE, OPTION_SUM, PRICE)
VALUES
(NEXTVAL('SGT_PRIVATE_MENU_SEQ'), 'T', 'sanghyeon', 3, 1, 1, false, false, 'T', 1200, 6300);
INSERT INTO SGT_PRIVATE_MENU 
(PRIVATE_MENU_ID, CUP, ACCOUNT_ID, MENU_ID, SHOT, SYRUP, WHIPPED_CREAM, DRIZZLE, SIZE, OPTION_SUM, PRICE)
VALUES
(NEXTVAL('SGT_PRIVATE_MENU_SEQ'), 'T', 'sanghyeon', 18, 0, 1, true, false, 'G', 1200, 7100);

INSERT INTO SGT_PRIVATE_MENU 
(PRIVATE_MENU_ID, CUP, ACCOUNT_ID, MENU_ID, SHOT, SYRUP, WHIPPED_CREAM, DRIZZLE, SIZE, OPTION_SUM, PRICE)
VALUES
(NEXTVAL('SGT_PRIVATE_MENU_SEQ'), 'T', 'ujeong', 21, 1, 1, false, false, 'T', 1200, 7300);
INSERT INTO SGT_PRIVATE_MENU 
(PRIVATE_MENU_ID, CUP, ACCOUNT_ID, MENU_ID, SHOT, SYRUP, WHIPPED_CREAM, DRIZZLE, SIZE, OPTION_SUM, PRICE)
VALUES
(NEXTVAL('SGT_PRIVATE_MENU_SEQ'), 'T', 'ujeong', 14, 0, 1, true, false, 'G', 1200, 8400);

INSERT INTO SGT_PRIVATE_MENU 
(PRIVATE_MENU_ID, CUP, ACCOUNT_ID, MENU_ID, SHOT, SYRUP, WHIPPED_CREAM, DRIZZLE, SIZE, OPTION_SUM, PRICE)
VALUES
(NEXTVAL('SGT_PRIVATE_MENU_SEQ'), 'T', 'heejae', 6, 1, 1, false, false, 'T', 1200, 6800);
INSERT INTO SGT_PRIVATE_MENU 
(PRIVATE_MENU_ID, CUP, ACCOUNT_ID, MENU_ID, SHOT, SYRUP, WHIPPED_CREAM, DRIZZLE, SIZE, OPTION_SUM, PRICE)
VALUES
(NEXTVAL('SGT_PRIVATE_MENU_SEQ'), 'T', 'heejae', 13, 0, 1, true, false, 'G', 1200, 6200);
