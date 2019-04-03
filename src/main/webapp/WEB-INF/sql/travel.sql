-------------------------------------- 
-- sys ---------------------------
CREATE USER travel IDENTIFIED BY 0000;

GRANT CONNECT, resource TO TRAVEL;
GRANT CREATE VIEW TO travel;
COMMIT;

--------------------------------------
CREATE SEQUENCE mb_idx_seq;

CREATE TABLE t1_member(
	mb_idx NUMBER PRIMARY KEY,
	mb_id VARCHAR2(20) NOT NULL,
	mb_email VARCHAR2(50) NOT NULL,
	mb_password VARCHAR2(50) NOT NULL,
	mb_name VARCHAR2(50) NOT NULL,
	mb_nickname VARCHAR2(50) NOT NULL,
	mb_nickupdate TIMESTAMP DEFAULT SYSDATE,
	mb_lev NUMBER DEFAULT 0,
	mb_levupdate TIMESTAMP DEFAULT SYSDATE,
	mb_yy VARCHAR2(4) NOT NULL,
	mb_mm VARCHAR2(2) NOT NULL,
	mb_dd VARCHAR2(2) NOT NULL,
	mb_joindate TIMESTAMP DEFAULT SYSDATE,
	mb_intercept_date TIMESTAMP DEFAULT '',
	mb_key VARCHAR2(30) DEFAULT '',
	setkey VARCHAR2(250) DEFAULT '',
	mb_1 VARCHAR2(250),
	mb_2 VARCHAR2(250),
	mb_3 VARCHAR2(250),
	mb_4 VARCHAR2(250),
	mb_5 VARCHAR2(250)
);

CREATE SEQUENCE gb_idx_seq;

CREATE TABLE t1_group_board(
	gb_idx NUMBER PRIMARY KEY,
	gb_id VARCHAR2(50) NOT NULL,
	gb_subject VARCHAR2(50) NOT NULL
);

CREATE SEQUENCE hs_idx_seq;

CREATE TABLE t1_history(
	hs_idx NUMBER PRIMARY KEY,
	mb_id VARCHAR2(20) NOT NULL,
	hs_login TIMESTAMP NOT NULL,
	hs_ip VARCHAR2 (20)NOT NULL
);

CREATE SEQUENCE bt_idx_seq;

CREATE TABLE t1_board_table(
	bt_idx NUMBER PRIMARY KEY,
	bt_table VARCHAR2(30) UNIQUE NOT NULL,
	gb_idx NUMBER,
	gb_subject VARCHAR2(50),
	bt_subject VARCHAR2(100) NOT NULL
);

SELECT * FROM t1_MEMBER;

COMMIT;

CREATE SEQUENCE menu_idx_seq;

CREATE TABLE t1_menu(
	menu_id NUMBER PRIMARY KEY,
	menu_code NUMBER NOT NULL,
	menu_sub VARCHAR2(22) NOT NULL,
	menu_name VARCHAR2(100) NOT NULL,
	bt_table VARCHAR2(30) NOT NULL,
	menu_type VARCHAR2(100) NOT NULL,
	menulist_type VARCHAR2(30) NOT NULL,
	menu_use NUMBER DEFAULT 1
);

