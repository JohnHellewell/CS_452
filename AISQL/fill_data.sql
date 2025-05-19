-- Accounts (one per team, all under the same event organizer for simplicity)
INSERT INTO Account (email, password) VALUES
('team1@example.com', 'pass1'),
('team2@example.com', 'pass2'),
('team3@example.com', 'pass3'),
('team4@example.com', 'pass4'),
('team5@example.com', 'pass5'),
('team6@example.com', 'pass6'),
('team7@example.com', 'pass7'),
('team8@example.com', 'pass8');

-- Teams
INSERT INTO Team (name, description) VALUES
('Thunder Rats', 'Small but fierce.'),
('RoboLords', 'Precision and power.'),
('Plastic Punishers', 'Champions of 1lb plastic bots.'),
('Bug Crushers', 'We crush bugs, literally.'),
('Assault & Batteries', 'Student team from BYU'),
('Mini Mechs', 'Micro bots, mega damage.'),
('Fairy Flurry', 'Speedy 150g bots with attitude.'),
('Beetle Battalion', '3lb beetles bred for war.');

-- Link Accounts to Teams (1-to-1)
INSERT INTO Account_on_Team (account_id, team_id) VALUES
(1, 1), (2, 2), (3, 3), (4, 4),
(5, 5), (6, 6), (7, 7), (8, 8);

-- Weight Classes
INSERT INTO weight_class (name, description) VALUES
('Fairyweight (150g)', 'Tiny but mighty bots.'),
('Antweight Plastic (1lb)', '1lb bots made only of plastic.'),
('Beetleweight (3lb)', 'Heavier bots with more power.');

-- Events (All in SLC, same organizer)
INSERT INTO Event (event_organizer_id, description) VALUES
(1, 'SLC Spring Bash 2025'),
(1, 'SLC Summer Rumble 2025'),
(1, 'SLC Autumn Havoc 2025');

-- Brackets (3 per event, 1 per weight class)
-- Event 1
INSERT INTO Bracket (event_id, weight_class_id) VALUES (1, 1), (1, 2), (1, 3);
-- Event 2
INSERT INTO Bracket (event_id, weight_class_id) VALUES (2, 1), (2, 2), (2, 3);
-- Event 3
INSERT INTO Bracket (event_id, weight_class_id) VALUES (3, 1), (3, 2), (3, 3);

-- Robots (8 per weight class, one per team, reused across brackets)

-- Fairyweight robots
INSERT INTO Robot (team_id, weight_class_id, name, ranking_points, description, photo_url) VALUES
(1, 1, 'Zap Rat', 10, 'Fast rat-shaped bot.', 'photos/zap_rat.jpg'),
(2, 1, 'Nano Blade', 12, 'Fairy spinner.', 'photos/nano_blade.jpg'),
(3, 1, 'Lil Thrasher', 15, 'Tiny drum.', 'photos/lil_thrasher.jpg'),
(4, 1, 'Mite Fighter', 9, 'Quick wedge.', 'photos/mite_fighter.jpg'),
(5, 1, 'Phalanx', 41, '2WD fork wedge bot', 'photos/legion.jpg'),
(6, 1, 'Pixie Punch', 7, 'Compact pusher.', 'photos/pixie_punch.jpg'),
(7, 1, 'Whirlwind', 11, 'Whirling flail.', 'photos/whirlwind.jpg'),
(8, 1, 'Cricket Kick', 13, 'Bug-themed kicker.', 'photos/cricket_kick.jpg');

-- Plastic Antweights
INSERT INTO Robot (team_id, weight_class_id, name, ranking_points, description, photo_url) VALUES
(1, 2, 'Rattletrap', 22, 'Plastic lifter.', 'photos/rattletrap.jpg'),
(2, 2, 'CrushCube', 16, 'Boxy flipper.', 'photos/crushcube.jpg'),
(3, 2, 'PolyPop', 19, 'Plastic spinner.', 'photos/polypop.jpg'),
(4, 2, 'WedgeMe', 25, 'Durable wedge.', 'photos/wedgeme.jpg'),
(5, 2, 'Legion', 20, '4WD Beater bar with self-righting arm', 'photos/legion.jpg'),
(6, 2, 'Plastic Doom', 17, 'Well-armed wedge.', 'photos/plastic_doom.jpg'),
(7, 2, 'ShredLite', 21, 'Light spinner.', 'photos/shredlite.jpg'),
(8, 2, 'Antsy', 23, 'Fast ant bot.', 'photos/antsy.jpg');

-- Beetleweights
INSERT INTO Robot (team_id, weight_class_id, name, ranking_points, description, photo_url) VALUES
(1, 3, 'Jawbreaker', 33, 'Drum spinner.', 'photos/jawbreaker.jpg'),
(2, 3, 'Ram Raider', 29, 'Brute force rammer.', 'photos/ram_raider.jpg'),
(3, 3, 'Beetle Buster', 27, 'Undercutter.', 'photos/beetle_buster.jpg'),
(4, 3, 'War Drum', 35, 'Double weapon.', 'photos/war_drum.jpg'),
(5, 3, 'Orbit', 26, '4WD Beater Bar with self righting arm. 4140 hardened steel spinner.', 'photos/orbit.jpg'),
(6, 3, 'Blade Beetle', 30, 'Sharp and fast.', 'photos/blade_beetle.jpg'),
(7, 3, 'Steel Thorn', 32, 'Armor-heavy wedge.', 'photos/steel_thorn.jpg'),
(8, 3, 'Mauler Max', 28, 'Control bot.', 'photos/mauler_max.jpg');

-- Register Robots to Brackets (sample overlap across events)

-- Fairyweight Brackets
INSERT INTO robot_registration (bracket_id, robot_id) VALUES
-- Event 1 Fairy
(1, 1), (1, 2), (1, 3), (1, 5), (1, 6), (1, 7),
-- Event 2 Fairy
(4, 1), (4, 3), (4, 4), (4, 5), (4, 8),
-- Event 3 Fairy
(7, 2), (7, 3), (7, 5), (7, 6), (7, 7), (7, 8);

-- Plastic Ant Brackets
INSERT INTO robot_registration (bracket_id, robot_id) VALUES
-- Event 1 Ant
(2, 9), (2, 10), (2, 11), (2, 12), (2, 13), (2, 14),
-- Event 2 Ant
(5, 9), (5, 11), (5, 12), (5, 15), (5, 16),
-- Event 3 Ant
(8, 10), (8, 12), (8, 13), (8, 14), (8, 16);

-- Beetle Brackets
INSERT INTO robot_registration (bracket_id, robot_id) VALUES
-- Event 1 Beetle
(3, 17), (3, 18), (3, 19), (3, 20), (3, 21),
-- Event 2 Beetle
(6, 17), (6, 18), (6, 20), (6, 22), (6, 24),
-- Event 3 Beetle
(9, 18), (9, 19), (9, 21), (9, 23), (9, 24);
