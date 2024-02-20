DROP DATABASE IF EXISTS assignment_06;
CREATE DATABASE assignment_06;
USE assignment_06;

CREATE TABLE department (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE position (
    position_id INT PRIMARY KEY AUTO_INCREMENT,
    position_name ENUM("Dev", "Test", "Scrum Master", "PM") UNIQUE NOT NULL
);

CREATE TABLE account (
    account_id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(50) UNIQUE NOT NULL,
    username VARCHAR(50) UNIQUE NOT NULL,
    full_name VARCHAR(50) NOT NULL,
    department_id INT,
    position_id INT,
    create_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    FOREIGN KEY (department_id) REFERENCES department (department_id),
    FOREIGN KEY (position_id) REFERENCES position (position_id)
);

CREATE TABLE `group` (
    group_id INT PRIMARY KEY AUTO_INCREMENT,
    group_name VARCHAR(50) UNIQUE NOT NULL,
    creator_id INT,
    create_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    FOREIGN KEY (creator_id) REFERENCES account (account_id)
);

CREATE TABLE group_account (
    group_id INT,
    account_id INT,
    join_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    PRIMARY KEY (group_id, account_id),
    FOREIGN KEY (group_id) REFERENCES `group` (group_id),
    FOREIGN KEY (account_id) REFERENCES account (account_id)
);

CREATE TABLE type_question (
    type_id INT PRIMARY KEY AUTO_INCREMENT,
    type_name ENUM("Essay", "Multiple-Choice") UNIQUE NOT NULL
);

CREATE TABLE category_question (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE question (
    question_id INT PRIMARY KEY AUTO_INCREMENT,
    content VARCHAR(50) UNIQUE NOT NULL,
    category_id INT,
    type_id INT,
    creator_id INT,
    create_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    FOREIGN KEY (category_id) REFERENCES category_question (category_id),
    FOREIGN KEY (type_id) REFERENCES type_question (type_id),
    FOREIGN KEY (creator_id) REFERENCES account (account_id)
);

CREATE TABLE answer (
    answer_id INT PRIMARY KEY AUTO_INCREMENT,
    content VARCHAR(50) NOT NULL,
    question_id INT,
    is_correct BOOLEAN NOT NULL,
    FOREIGN KEY (question_id) REFERENCES question (question_id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS exam;
CREATE TABLE exam (
    exam_id INT PRIMARY KEY AUTO_INCREMENT,
    code CHAR(8) UNIQUE NOT NULL,
    title VARCHAR(50) UNIQUE NOT NULL,
    category_id INT,
    duration INT NOT NULL,
    creator_id INT,
    create_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    FOREIGN KEY (category_id) REFERENCES category_question (category_id),
    FOREIGN KEY (creator_id) REFERENCES account (account_id)
);

DROP TABLE IF EXISTS exam_question;
CREATE TABLE exam_question (
    exam_id INT,
    question_id INT,
    PRIMARY KEY (exam_id, question_id),
    FOREIGN KEY (exam_id) REFERENCES exam (exam_id) ON DELETE CASCADE,
    FOREIGN KEY (question_id) REFERENCES question (question_id) ON DELETE CASCADE
);

-- Thêm dữ liệu cho bảng department
INSERT INTO department  (department_name)
VALUES                  
                        ("Marketing"    ),
                        ("Sale"         ),
                        ("Bảo vệ"       ),
                        ("Nhân sự"      ),
                        ("Kỹ thuật"     ),
                        ("Tài chính"    ),
                        ("Phó giám đốc" ),
                        ("Giám đốc"     ),
                        ("Thư kí"       ),
                        ("Bán hàng"     ),
                        ("Phong cho"   ); 

-- Thêm dữ liệu cho bảng position
INSERT INTO position    (position_name )
VALUES                  ("Dev"         ),
                        ("Test"        ),
                        ("Scrum Master"),
                        ("PM"          );

-- Thêm dữ liệu cho bảng account
INSERT INTO account (email                           , username      , full_name           , department_id, position_id, create_date)
VALUES              ("haidang29productions@gmail.com", "dangblack"   , "Nguyen Hai Dang"   , 1            , 1          , "2010-03-05"),
                    ("account1@gmail.com"            , "quanganh"    , "Tong Quang Anh"    , 2            , 2          , "2011-03-05"),
                    ("account2@gmail.com"            , "vanchien"    , "Nguyen Van Chien"  , 2            , 3          , "2012-03-07"),
                    ("account3@gmail.com"            , "cocoduongqua", "Duong Do"          , 3            , 4          , "2013-03-08"),
                    ("account4@gmail.com"            , "doccocaubai" , "Nguyen Chien Thang", 5            , 4          , "2014-03-10"),
                    ("dapphatchetngay@gmail.com"     , "khabanh"     , "Ngo Ba Kha"        , 3            , 3          , "2015-04-05"),
                    ("songcodaoly@gmail.com"         , "huanhoahong" , "Bui Xuan Huan"     , 4            , 2          , "2016-04-05"),
                    ("sontungmtp@gmail.com"          , "tungnui"     , "Nguyen Thanh Tung" , 4            , 1          , "2018-04-07"),
                    ("duongghuu@gmail.com"           , "duongghuu"   , "Duong Van Huu"     , 4            , 1          , "2020-04-07"),
                    ("vtiaccademy@gmail.com"         , "vtiaccademy" , "Vi Ti Ai"          , 4            , 1          , "2022-04-09");

-- Thêm dữ liệu cho bảng group
INSERT INTO `group` (group_name         , creator_id, create_date)
VALUES              ("Testing System"   , 4         , "2019-03-05"),
                    ("Developement"     , 4         , "2022-03-07"),
                    ("VTI Sale 01"      , 4         , "2021-03-09"),
                    ("VTI Sale 02"      , 4         , "2016-03-10"),
                    ("VTI Sale 03"      , 3         , "2015-03-28"),
                    ("VTI Creator"      , 2         , "2018-04-06"),
                    ("VTI Marketing 01" , 1         , "2019-04-07"),
                    ("Management"       , 8         , "2017-04-08"),
                    ("Chat with love"   , 9         , "2016-04-09"),
                    ("Vi Ti Ai"         , 10        , "2019-04-10");

-- Thêm dữ liệu cho bảng group_account
INSERT INTO group_account   (group_id, account_id, join_date )
VALUES                      (1       , 1         , "2019-03-05"),
                            (1       , 2         , "2020-03-07"),
                            (2       , 3         , "2018-03-09"),
                            (2       , 4         , "2017-03-10"),
                            (2       , 2         , "2020-03-28"),
                            (3       , 8         , "2021-04-06"),
                            (1       , 8         , "2022-04-07"),
                            (2       , 8         , "2022-04-08"),
                            (3       , 9         , "2022-04-09"),
                            (4       , 10        , "2016-04-10");

-- Thêm dữ liệu cho bảng type_question
INSERT INTO type_question (type_name) VALUES ("Essay"), ("Multiple-Choice"); 

-- Thêm dữ liệu cho bảng category_question
INSERT INTO category_question   (category_name)
VALUES                          ("Java"       ),
                                ("ASP.NET"    ),
                                ("ADO.NET"    ),
                                ("SQL"        ),
                                ("Postman"    ),
                                ("Ruby"       ),
                                ("Python"     ),
                                ("C++"        ),
                                ("C Sharp"    ),
                                ("PHP"        ); 

-- Thêm dữ liệu cho bảng question
INSERT INTO question    (content          , category_id, type_id, creator_id, create_date)
VALUES                  ("Câu hỏi về Java", 1          , 1      , 6         , "2023-04-05"),
                        ("Câu Hỏi về PHP" , 10         , 2      , 2         , "2021-04-05"),
                        ("Hỏi về C#"      , 9          , 2      , 6         , "2021-04-06"),
                        ("Hỏi về Ruby"    , 9          , 1      , 2         , "2022-04-06"),
                        ("Hỏi về Postman" , 9          , 1      , 6         , "2022-04-06"),
                        ("Hỏi về ADO.NET" , 2          , 2      , 6         , "2016-04-06"),
                        ("Hỏi về ASP.NET" , 2          , 1      , 2         , "2016-04-06"),
                        ("Hỏi về C++"     , 2          , 1      , 2         , "2017-04-07"),
                        ("Hỏi về SQL"     , 1          , 2      , 3         , "2017-04-07"),
                        ("Hỏi về Python"  , 7          , 1      , 10        , "2018-04-07");

-- Thêm dữ liệu cho bảng answer
INSERT INTO answer  (content     , question_id, is_correct)
VALUES              ("Trả lời 01", 1          , FALSE     ),
                    ("Trả lời 02", 1          , TRUE      ),
                    ("Trả lời 03", 1          , FALSE     ),
                    ("Trả lời 04", 1          , TRUE      ),
                    ("Trả lời 05", 2          , TRUE      ),
                    ("Trả lời 06", 3          , TRUE      ),
                    ("Trả lời 07", 4          , FALSE     ),
                    ("Trả lời 08", 8          , FALSE     ),
                    ("Trả lời 09", 9          , TRUE      ),
                    ("Trả lời 10", 10         , TRUE      );

-- Thêm dữ liệu cho bảng exam
INSERT INTO exam    (code     , title           , category_id, duration, creator_id, create_date)
VALUES              ("VTIQ001", "Đề thi C#"     , 1          , 60      , 7         , "2019-04-05"),
                    ("VTIQ002", "Đề thi PHP"    , 10         , 60      , 1         , "2019-04-05"),
                    ("VTIQ003", "Đề thi C++"    , 5          , 120     , 2         , "2019-04-07"),
                    ("VTIQ004", "Đề thi Java"   , 7          , 60      , 8         , "2015-04-08"),
                    ("VTIQ005", "Đề thi Ruby"   , 4          , 120     , 3         , "2015-04-10"),
                    ("VTIQ006", "Đề thi Postman", 5          , 60      , 6         , "2016-04-05"),
                    ("VTIQ007", "Đề thi SQL"    , 5          , 60      , 8         , "2016-04-05"),
                    ("VTIQ008", "Đề thi Python" , 8          , 60      , 8         , "2022-04-07"),
                    ("VTIQ009", "Đề thi ADO.NET", 4          , 90      , 3         , "2020-04-07"),
                    ("VTIQ010", "Đề thi ASP.NET", 7          , 90      , 10        , "2020-04-08");

-- Thêm dữ liệu cho bảng exam_question
INSERT INTO exam_question   (question_id, exam_id)
VALUES                      (1          , 3     ),
							(2          , 3     ),
							(1          , 1	    ),
                            (2          , 1      ),
                            (3          , 1      ),
                            (4          , 1      ),
                            (5          , 1      ),
                            (6          , 2      ),
                            (7          , 2      ),
                            (8          , 3      ),
                            (9          , 8      ),
                            (10         , 10     );

-- ===============INSERT=================== -- 
-- Question 1: Tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các
-- account thuộc phòng ban đó.
DROP PROCEDURE IF EXISTS sp_1;
DELIMITER $$
CREATE PROCEDURE sp_1(IN IN_Depart_name varchar(50))
BEGIN
    SELECT account.*
    FROM Department 
    JOIN `account` USING(department_id)
    WHERE department_name = IN_Depart_name;
END$$
DELIMITER ;

CALL sp_1("sale");

-- Question 2: Tạo store để in ra số lượng account trong mỗi group.
DROP PROCEDURE IF EXISTS P_Number_of_accounts_in_the_group;
DELIMITER $$
CREATE PROCEDURE P_Number_of_accounts_in_the_group()
BEGIN
    SELECT group_name, count(account_id) as account_count
    FROM `group`
    LEFT JOIN group_account USING(group_id)
    GROUP BY group_id;
END $$
DELIMITER ;

CALL P_Number_of_accounts_in_the_group();
-- Question 3: Tạo store để thống kê mỗi type question có bao nhiêu question được tạo
-- trong tháng hiện tại.
DROP PROCEDURE IF EXISTS P_number_of_questions_in_the_type_question;
DELIMITER $$
CREATE PROCEDURE P_number_of_questions_in_the_type_question()
    BEGIN
            WITH C1 as
            (
            SELECT *
            FROM Question
            WHERE MONTH(create_date) = MONTH(curdate()) AND YEAR(create_date) = YEAR(curdate())
            )
            SELECT Type_question.*, COUNT(Question_id) as question_count
            FROM type_question
            LEFT JOIN C1 USING(type_id)
            GROUP BY type_id;
    END $$
DELIMITER ;

CALL P_number_of_questions_in_the_type_question();

-- ============================= --



-- Question 4: Tạo store để trả ra id của type question có nhiều câu hỏi nhất.
DROP PROCEDURE IF EXISTS P_USE_More_questions_in_the_type_question;
DELIMITER $$
CREATE PROCEDURE P_USE_More_questions_in_the_type_question(OUT OUT_Type_id INT)
    BEGIN
        WITH question_count as
        (
            SELECT type_question.*, COUNT(question_id) as sl
            FROM type_question
            LEFT JOIN question USING(type_id)
            GROUP BY type_id
        )
        SELECT Type_id INTO OUT_Type_id
        FROM question_count
        WHERE sl = (SELECT MAX(sl) FROM question_count);
    END $$
DELIMITER ;

SET @V_Type_id = 0;
CALL P_USE_More_questions_in_the_type_question(@V_Type_id );
SELECT @V_Type_id;

-- FUNCTION 
DROP FUNCTION IF EXISTS P_fn_4;
DELIMITER $$
CREATE FUNCTION P_fn_4() RETURNS INT
    BEGIN
        DECLARE OUT_Type_id INT;
        
        WITH question_count as
        (
            SELECT type_question.*, COUNT(question_id) as sl
            FROM type_question
            LEFT JOIN question USING(type_id)
            GROUP BY type_id
        )
        SELECT Type_id INTO OUT_Type_id
        FROM question_count
        WHERE sl = (SELECT MAX(sl) FROM question_count);
        RETURN OUT_Type_id;
    END $$
DELIMITER ;
    
SELECT P_fn_4();
    


-- Question 5: Sử dụng store ở question 4 để tìm ra tên của type question.
SELECT type_name
FROM type_question
WHERE type_id = @V_Type_id ;

-- Function
SELECT type_name
FROM type_question
WHERE type_id = P_fn_4() ;


-- Question 6: Viết 1 store cho phép người dùng nhập vào 1 chuỗi và trả về group có tên
-- chứa chuỗi của người dùng nhập vào hoặc trả về user có username chứa chuỗi của người dùng nhập vào.
DROP PROCEDURE IF EXISTS P_GROUP_AND_Username;
DELIMITER $$
CREATE PROCEDURE P_GROUP_AND_Username(IN IN_String VARCHAR(50))
    BEGIN
        SELECT "Group" as TYPE, group_name as name
        FROM `Group`
        WHERE group_name like concat('%' , IN_String, '%')
        UNION 
        SELECT "Account" as type, username as name
        FROM `account`
        WHERE username LIKE concat('%', IN_String, '%'); 
       
    END$$
DELIMITER ;

call P_GROUP_AND_Username('g');

-- Question 7: Viết 1 store cho phép người dùng nhập vào thông tin fullName, email và trong store sẽ tự động gán:
-- username sẽ giống email nhưng bỏ phần @..mail đi
-- positionID: sẽ có default là developer
-- departmentID: sẽ được cho vào 1 phòng chờ
-- Sau đó in ra kết quả tạo thành công

DROP PROCEDURE IF EXISTS P_Add_account;
DELIMITER $$
CREATE PROCEDURE P_Add_account(IN In_full_name VARCHAR(50), IN IN_email VARCHAR(50))
    BEGIN
        DECLARE V_username VARCHAR(50) DEFAULT SUBSTRING_INDEX(IN_email, '@', 1);
        DECLARE V_department_id INT;
        DECLARE V_position_id INT;
        DECLARE V_create_date DATE DEFAULT curdate();
        
        SELECT Department_id INTO V_department_id
        FROM department
        WHERE department_name = "Phòng chờ";
        
        SELECT position_id INTO V_position_id
        FROM position
        WHERE position_name = "DEV";
        
        INSERT INTO `account`(email, username, full_name, department_id, position_id, create_date)
        VALUES 
                (IN_email, V_username, In_full_name, V_department_id, V_position_id, V_create_date);
        SELECT * FROM `account` WHERE username = V_username;
    END$$
DELIMITER ;

call P_Add_account ('NGoooooo', 'ngooooooo11199@gmail.com');

-- Question 8: Viết 1 store cho phép người dùng nhập vào Essay hoặc Multiple-Choice
-- để thống kê câu hỏi essay hoặc multiple-choice nào có content dài nhất
DROP PROCEDURE IF EXISTS Question_8;
DELIMITER $$
CREATE PROCEDURE Question_8(IN V_Type_name ENUM('Multiple-Choice', 'Essay'))
BEGIN
        WITH Content_count as
        (
        SELECT *, CHAR_LENGTH(content) as sl
        FROM Question
        RIGHT JOIN Type_question USING(Type_id)
        WHERE type_name = V_Type_name
        )
        SELECT *
        FROM Content_count
        WHERE sl = (SELECT MAX(sl) FROM Content_count) ; 
END$$
DELIMITER ;

CALL Question_8('Multiple-Choice');

-- Question 9: Viết 1 store cho phép người dùng xóa exam dựa vào ID
DROP PROCEDURE IF EXISTS Question_9;
DELIMITER $$
CREATE PROCEDURE Question_9(IN V_ID INT)
BEGIN 
    DELETE FROM exam WHERE exam_id = V_ID;
END$$
DELIMITER ;
-- Question 10: Tìm ra các exam được tạo từ 3 năm trước và xóa các exam đó đi (sử
-- dụng store ở câu 9 để xóa)
-- Sau đó iDROP PROCEDURE IF EXISTS sp_10;
-- in số lượng record đã remove từ các table liên quan trong khi
DELIMITER $$
CREATE PROCEDURE sp_10 ()
BEGIN
    DECLARE done BOOLEAN DEFAULT FALSE;
    DECLARE id INT;
    DECLARE removed_items INT DEFAULT 0;
    DECLARE removed_exam_question INT;
    DECLARE cur CURSOR FOR SELECT exam_id FROM exam WHERE create_date < CURRENT_DATE - INTERVAL 3 YEAR;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO id;
    
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        SELECT COUNT(exam_id) INTO removed_exam_question
        FROM exam_question
        WHERE exam_id = id;
        
        SET removed_items = removed_items + removed_exam_question + 1;

        CALL sp_09(id);
    END LOOP;
    CLOSE cur;
    
    SELECT CONCAT("Số lượng bản ghi đã bị xóa là: ", removed_items) AS message;
END $$
DELIMITER ;

CALL sp_10();



-- Question 11: Viết store cho phép người dùng xóa phòng ban bằng cách người dùng
-- nhập vào tên phòng ban và các account thuộc phòng ban đó sẽ được
-- chuyển về phòng ban default là phòng ban chờ việc
DROP PROCEDURE IF EXISTS Question_11;
DELIMITER $$
CREATE PROCEDURE Question_11(IN V_Department_name VARCHAR(50))
BEGIN 
    DECLARE V_department_id INT;
    DECLARE V_department_id_Phong_cho INT;
    
    SELECT department_id INTO V_department_id FROM department WHERE department_name = V_Department_name;
    SELECT department_id INTO V_department_id_Phong_cho FROM department WHERE department_name = 'Phong cho';
    
    UPDATE account SET department_id = V_department_id_Phong_cho WHERE department_id = V_department_id;
    
    DELETE FROM department WHERE department_name = V_Department_name;
END$$
DELIMITER ;

CALL Question_11('Marketing');

-- Question 12: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong năm nay
DROP PROCEDURE IF EXISTS Question_12;
DELIMITER $$
CREATE PROCEDURE Question_12()
    BEGIN
        WITH MONTH_12 as
        (
                    SELECT 1 AS MONTH
            UNION   SELECT 2 AS MONTH
            UNION   SELECT 3 AS MONTH
            UNION   SELECT 4 AS MONTH
            UNION   SELECT 5 AS MONTH
            UNION   SELECT 6 AS MONTH
            UNION   SELECT 7 AS MONTH
            UNION   SELECT 8 AS MONTH
            UNION   SELECT 9 AS MONTH
            UNION   SELECT 10 AS MONTH
            UNION   SELECT 11 AS MONTH
            UNION   SELECT 12 AS MONTH
        )
        SELECT MONTH, COUNT(question_id)
        FROM MONTH_12 
        LEFT JOIN Question Q ON MONTH(Q.create_date) = MONTH
        GROUP BY MONTH;
    END $$
DELIMITER ;

CALL Question_12();

-- Question 13: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong 6 tháng gần đây nhất
-- (Nếu tháng nào không có thì sẽ in ra là "không có câu hỏi nào trong tháng")
WITH CTE_6_MONTH as
(
            SELECT MONTH(DATE_SUB(CURDATE(), INTERVAL 6 MONTH)) as MONTH
    UNION   SELECT MONTH(DATE_SUB(CURDATE(), INTERVAL 5 MONTH)) as MONTH
    UNION   SELECT MONTH(DATE_SUB(CURDATE(), INTERVAL 4 MONTH)) as MONTH
    UNION   SELECT MONTH(DATE_SUB(CURDATE(), INTERVAL 3 MONTH)) as MONTH
    UNION   SELECT MONTH(DATE_SUB(CURDATE(), INTERVAL 2 MONTH)) as MONTH
    UNION   SELECT MONTH(DATE_SUB(CURDATE(), INTERVAL 1 MONTH)) as MONTH
)
SELECT MONTH, CASE 
                WHEN COUNT(question_id) = 0 THEN 'Không có câu trả lời'
                ELSE COUNT(question_id) END AS SL
FROM CTE_6_MONTH  G
LEFT JOIN 
    (SELECT question_id, content, Create_date 
    FROM question 
    WHERE Create_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH) AND Create_date <= curdate()) C ON G.MONTH = MONTH(C.Create_date)
GROUP BY MONTH;



