

CREATE TABLE Account (
    account_id int PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(50) NOT NULL,
    password VARCHAR(50) NOT NULL
);

CREATE TABLE Team (
    team_id int PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(30) NOT NULL,
    description VARCHAR(250)
);

CREATE TABLE Account_on_Team (
    account_id INT NOT NULL,
    team_id INT NOT NULL,
    PRIMARY KEY (account_id, team_id),
    FOREIGN KEY (account_id) REFERENCES Account (account_id),
    FOREIGN KEY (team_id) REFERENCES Team (team_id)
);

CREATE TABLE weight_class (
    weight_class_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(30) NOT NULL,
    description VARCHAR(250),
    CHECK (name IN ('Fairyweight 150g', 'Plastic Antweight 1lb', 'Beetleweight 3lb'))
);

CREATE TABLE Robot (
    robot_id INT PRIMARY KEY AUTO_INCREMENT,
    team_id INT NOT NULL,
    weight_class_id INT NOT NULL,
    name VARCHAR(30) NOT NULL,
    ranking_points INT DEFAULT 0,
    description VARCHAR(250),
    photo_url VARCHAR(100),
    FOREIGN KEY (weight_class_id) REFERENCES weight_class (weight_class_id),
    FOREIGN KEY (team_id) REFERENCES Team (team_id)
);

CREATE TABLE Event (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    event_organizer_id INT NOT NULL,
    description VARCHAR(2000),
    FOREIGN KEY (event_organizer_id) REFERENCES Account (account_id)
);

CREATE TABLE Bracket (
    bracket_id INT PRIMARY KEY AUTO_INCREMENT,
    event_id INT NOT NULL,
    weight_class_id INT NOT NULL,
    FOREIGN KEY (event_id) REFERENCES Event (event_id),
    FOREIGN KEY (weight_class_id) REFERENCES weight_class (weight_class_id)
);

CREATE TABLE robot_registration (
    bracket_id INT,
    robot_id INT,
    PRIMARY KEY (bracket_id, robot_id),
    FOREIGN KEY (bracket_id) REFERENCES Bracket (bracket_id),
    FOREIGN KEY (robot_id) REFERENCES Robot (robot_id)
);