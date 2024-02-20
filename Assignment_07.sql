DROP DATABASE IF EXISTS assignment_07;
CREATE DATABASE assignment_07;
USE assignment_07;

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
    FOREIGN KEY (creator_id) REFERENCES account (account_id) ON DELETE CASCADE
);

CREATE TABLE group_account (
    group_id INT,
    account_id INT,
    join_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    PRIMARY KEY (group_id, account_id),
    FOREIGN KEY (group_id) REFERENCES `group` (group_id),
    FOREIGN KEY (account_id) REFERENCES account (account_id) ON DELETE CASCADE
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
    FOREIGN KEY (creator_id) REFERENCES account (account_id) ON DELETE CASCADE
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
    FOREIGN KEY (creator_id) REFERENCES account (account_id) ON DELETE CASCADE
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


-- Question 1: Tạo trigger không cho phép người dùng nhập vào Group có ngày tạo trước 1 năm trước
DROP TRIGGER IF EXISTS Trigger_question_1;
DELIMITER $$
CREATE TRIGGER Trigger_question_1
BEFORE INSERT ON `Group`
FOR EACH ROW
BEGIN
    IF NEW.create_date < current_date - INTERVAL 1 YEAR THEN
        SIGNAL SQLSTATE '12345'
        SET MESSAGE_TEXT = 'nhap lai ngay';
    END IF;
END $$
DELIMITER ;

-- Question 2: Tạo trigger Không cho phép người dùng thêm bất kỳ user nào vào department "Sale" nữa, khi thêm thì hiện ra thông báo "Department
-- "Sale" cannot add more user"
DROP TRIGGER IF EXISTS Trigger_question_2;
DELIMITER $$
CREATE TRIGGER Trigger_question_2
BEFORE INSERT ON `account`
FOR EACH ROW
BEGIN
    DECLARE V_department_id int;
    
    SELECT Department_id INTO V_department_id FROM Department WHERE Department_name = 'sale';
    
    IF NEW.department_id = V_department_id THEN
        SIGNAL SQLSTATE '12345'
        SET MESSAGE_TEXT = "Department 'Sale' cannot add more user";
    END IF;
END $$
DELIMITER ;

-- Question 3: Cấu hình 1 group có nhiều nhất là 5 user
DROP TRIGGER IF EXISTS Trigger_question_3;
DELIMITER $$
CREATE TRIGGER Trigger_question_3
BEFORE INSERT ON group_account
FOR EACH ROW
BEGIN
    DECLARE V_Group_count int;
    
    SELECT Count(account_id) INTO V_Group_count FROM group_account WHERE group_id = NEW.group_id;
    
    IF V_Group_count >= 5 THEN
        SIGNAL SQLSTATE '12345'
        SET MESSAGE_TEXT = "Department 'Sale' cannot add more user";
    END IF;
END $$
DELIMITER ;

-- Question 4: Cấu hình 1 bài thi có nhiều nhất là 10 Question
DROP TRIGGER IF EXISTS Trigger_question_4;
DELIMITER $$
CREATE TRIGGER Trigger_question_4
BEFORE INSERT ON exam_question
FOR EACH ROW
BEGIN
    DECLARE V_question_count int;
    
    SELECT Count(question_id) INTO V_question_count 
    FROM exam_question 
    WHERE exam_id = NEW.exam_id;
    
    IF V_question_count >= 10 THEN
        SIGNAL SQLSTATE '12345'
        SET MESSAGE_TEXT = "Quá 10 record";
    END IF;
END $$
DELIMITER ;

-- Question 5: Tạo trigger không cho phép người dùng xóa tài khoản có email là
-- admin@gmail.com (đây là tài khoản admin, không cho phép user xóa),
-- còn lại các tài khoản khác thì sẽ cho phép xóa và sẽ xóa tất cả các thông
-- tin liên quan tới user đó
DROP TRIGGER IF EXISTS Trigger_question_5;
DELIMITER $$
CREATE TRIGGER Trigger_question_5
BEFORE DELETE ON account
FOR EACH ROW
BEGIN
    IF OLD.email = "admin@gmail.com" THEN
        SIGNAL SQLSTATE '12345'
        SET MESSAGE_TEXT = "Không được xóa tài khoản admin";
    END IF;
END $$
DELIMITER ;

-- Question 6: Không sử dụng cấu hình default cho field DepartmentID của table
-- Account, hãy tạo trigger cho phép người dùng khi tạo account không điền
-- vào departmentID thì sẽ được phân vào phòng ban "waiting Department"
DROP TRIGGER IF EXISTS Trigger_question_6;
DELIMITER $$
CREATE TRIGGER Trigger_question_6
BEFORE INSERT ON account
FOR EACH ROW
BEGIN
    DECLARE V_department_id INT;
    
    IF NEW.department_id IS NULL THEN
        SELECT department_id INTO V_department_id 
        FROM department 
        WHERE department_Name = "waiting Department" ;
    
        SET NEW.department_id = V_department_id;
    END IF;
END $$
DELIMITER ;

-- Question 7: Cấu hình 1 bài thi chỉ cho phép user tạo tối đa 4 answers cho mỗi
-- question, trong đó có tối đa 2 đáp án đúng.
DROP TRIGGER IF EXISTS Trigger_question_7;
DELIMITER $$
CREATE TRIGGER Trigger_question_7
BEFORE INSERT ON answer
FOR EACH ROW
BEGIN
    DECLARE V_answer_id INT;
    DECLARE V_is_correct INT;
    
    SELECT COUNT(answer_id) INTO V_answer_id FROM answer WHERE question_id = NEW.question_id ;
    SELECT COUNT(answer_id) INTO V_is_correct FROM answer WHERE question_id = NEW.question_id and is_correct = TRUE;
    
    IF V_answer_id >= 4 AND V_is_correct >= 2 THEN
        SIGNAL SQLSTATE '12345' 
        SET MESSAGE_TEXT = "Đã tối đa 4 câu answer hoặc đã đủ 2 câu đúng";
    END IF;
END $$
DELIMITER ;

-- Question 9: Viết trigger không cho phép người dùng xóa bài thi mới tạo được 2 ngày
DROP TRIGGER IF EXISTS Trigger_question_9;
DELIMITER $$
CREATE TRIGGER Trigger_question_9
BEFORE DELETE ON exam
FOR EACH ROW
BEGIN 
    IF OLD.create_date > current_date - INTERVAL 2 DAY THEN
        SIGNAL SQLSTATE '12345' 
        SET MESSAGE_TEXT = "Mới tạo 2 ngày nên k dc xóa";
    END IF;
END $$
DELIMITER ;

-- Question 10: Viết trigger chỉ cho phép người dùng chỉ được update, delete các
-- question khi question đó chưa nằm trong exam nào
DROP TRIGGER IF EXISTS Trigger_update_question_10;
DROP TRIGGER IF EXISTS Trigger_DEL_question_10;
DELIMITER $$
CREATE TRIGGER Trigger_DEL_question_10
BEFORE DELETE ON question
FOR EACH ROW
BEGIN 
    DECLARE V_exam_id INT;

    SELECT COUNT(exam_id) INTO V_exam_id FROM exam_question WHERE question_id = OLD.question_id;
    
    IF V_exam_id != 0 THEN
        SIGNAL SQLSTATE '12345' 
        SET MESSAGE_TEXT = "không được xóa";
    END IF;
END $$

CREATE TRIGGER Trigger_update_question_10
BEFORE UPDATE ON question
FOR EACH ROW
BEGIN 
    DECLARE V_exam_id INT;

    SELECT COUNT(exam_id) INTO V_exam_id FROM exam_question WHERE question_id = OLD.question_id;
    
    IF V_exam_id != 0 THEN
        SIGNAL SQLSTATE '12345' 
        SET MESSAGE_TEXT = "không được Update";
    END IF;
END $$
DELIMITER ;
-- Question 12: Lấy ra thông tin exam trong đó:
-- Duration <= 30 thì sẽ đổi thành giá trị "Short time"
-- 30 < Duration <= 60 thì sẽ đổi thành giá trị "Medium time"
-- Duration > 60 thì sẽ đổi thành giá trị "Long time"
SELECT exam_id, code, title, CASE
                                WHEN duration <= 30 THEN "Short time"
                                WHEN duration <= 60 THEN "Medium time"
                                ELSE "Long time" 
                                END as duration, create_date
                                        
FROM exam;
-- Question 13: Thống kê số account trong mỗi group và in ra thêm 1 column nữa có tên
-- là the_number_user_amount và mang giá trị được quy định như sau:
-- Nếu số lượng user trong group =< 5 thì sẽ có giá trị là few
-- Nếu số lượng user trong group <= 20 và > 5 thì sẽ có giá trị là normal
-- Nếu số lượng user trong group > 20 thì sẽ có giá trị là higher
SELECT `group`.*, CASE 
                    WHEN COUNT(account_id) <= 5 THEN "few"
                    WHEN COUNT(account_id) <= 20 AND COUNT(account_id) > 5 THEN "normal"
                    ELSE "higher" END AS the_number_user_amount
FROM  `group`
LEFT JOIN group_account USING(group_id)
GROUP BY group_id;

-- Question 14: Thống kê số mỗi phòng ban có bao nhiêu user, nếu phòng ban nào
-- không có user thì sẽ thay đổi giá trị 0 thành "Không có User"
SELECT Department.department_name, CASE 
                    WHEN COUNT(account_id) = 0 THEN "Không có User"
                    ELSE COUNT(account_id) END AS SL
FROM Department
LEFT JOIN `Account` USING(Department_id)
GROUP BY department_id;


