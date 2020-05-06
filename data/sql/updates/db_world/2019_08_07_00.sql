-- DB update 2019_08_04_00 -> 2019_08_07_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_08_04_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_08_04_00 2019_08_07_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1563729098518635225'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1563729098518635225');

UPDATE `creature_addon` SET `auras` = '25184' WHERE `guid` IN (21680,21682);
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (4251,4252,4507,4419,4620);
UPDATE `creature` SET `position_x` = -6181.54, `position_y` = -3901.89, `position_z` = -60.0522, `orientation` = 3.13433 WHERE `guid` = 21681;
UPDATE `creature` SET `position_x` = -6232.82, `position_y` = -3946.62, `position_z` = -58.7494 WHERE `guid` = 21552;
UPDATE `creature` SET `position_x` = -6215.8, `position_y` = -3941.91, `position_z` = -58.7492 WHERE `guid` = 21555;
UPDATE `creature` SET `position_x` = -6224.42, `position_y` = -3860.63, `position_z` = -58.7499 WHERE `guid` = 21556;
UPDATE `creature` SET `position_x` = -6210.56, `position_y` = -3843.66, `position_z` = -58.7499 WHERE `guid` = 21558;
UPDATE `creature` SET `orientation` = 2.80685 WHERE `guid` = 21570;

DELETE FROM `creature_text` WHERE `CreatureID` IN (4419,4620);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`)
VALUES
(4419,0,0,'The race will start in 1 minute!',14,0,100,5,0,0,1452,1,'Race Master Kronkrider - Race announcement - Area yell'),
(4419,1,0,'The goblins win the drag race!  Better luck next time, gnome team.',14,0,100,5,0,0,1538,1,'Race Master Kronkrider - Race winner goblins - Area yell'),
(4419,2,0,'The winner of the drag race is...the gnome team!  Great job guys!',14,0,100,5,0,0,1537,1,'Race Master Kronkrider - Race winner gnomes - Area yell'),
(4620,0,0,'Open for business! The goblin car is looking sharp and it''s sure to be a winner! Get your bets in before the race starts!',14,0,100,1,0,0,1509,1,'Fobeed - Race comment 1 - Area yell'),
(4620,0,1,'Smart money''s on the gnomes to take the next race! Get your money in while you still can!',14,0,100,1,0,0,1510,1,'Fobeed - Race comment 2 - Area yell'),
(4620,1,0,'And they''re off!',14,0,100,1,0,0,2124,1,'Fobeed - Race start - Area yell');

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (4507,4251,4252) AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (450700,450701,425100,425101,425102,425103,425104,425200,425201,425202,425203,425204) AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
-- Daisy
(4507,0,0,0,11,0,100,0,0,0,0,0,0,80,450700,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Daisy - On Respawn - Call Action List'),
(4507,0,1,2,38,1,100,1,1,1,0,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Daisy - On Data Set 1 1 (Phase 1) - Set Phase 2 (No Repeat)'),
(4507,0,2,3,61,0,100,0,0,0,0,0,0,1,1,0,0,0,0,0,10,21549,4419,0,0,0,0,0,0,'Daisy - Linked - Say Line 1 (Race Master Kronkrider)'),
(4507,0,3,0,61,0,100,0,0,0,0,0,0,80,450701,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Daisy - Linked - Call Action List'),
(4507,0,4,5,38,1,100,1,1,2,0,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Daisy - On Data Set 1 2 (Phase 1) - Set Phase 2 (No Repeat)'),
(4507,0,5,6,61,0,100,0,0,0,0,0,0,1,2,0,0,0,0,0,10,21549,4419,0,0,0,0,0,0,'Daisy - Linked - Say Line 2 (Race Master Kronkrider)'),
(4507,0,6,0,61,0,100,0,0,0,0,0,0,80,450701,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Daisy - Linked - Call Action List'),

(450700,9,0,0,0,0,100,0,30000,90000,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Daisy - On Script - Set Active On'),
(450700,9,1,0,0,0,100,0,0,0,0,0,0,80,425100,2,0,0,0,0,10,21680,4251,0,0,0,0,0,0,'Daisy - On Script - Call Action List (Goblin Racer)'),
(450700,9,2,0,0,0,100,0,0,0,0,0,0,80,425200,2,0,0,0,0,10,21682,4252,0,0,0,0,0,0,'Daisy - On Script - Call Action List (Gnome Racer)'),
(450700,9,3,0,0,0,100,0,10000,10000,0,0,0,1,0,0,0,0,0,0,10,21549,4419,0,0,0,0,0,0,'Daisy - On Script - Say Line 0 (Race Master Kronkrider)'),
(450700,9,4,0,0,0,100,0,30000,30000,0,0,0,1,0,0,0,0,0,0,10,21145,4620,0,0,0,0,0,0,'Daisy - On Script - Say Line 0 (Fobeed)'),
(450700,9,5,0,0,0,100,0,30000,30000,0,0,0,5,36,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Daisy - On Script - Play Emote ''ONESHOT_ATTACK1H'''),
(450700,9,6,0,0,0,100,0,0,0,0,0,0,1,1,0,0,0,0,0,10,21145,4620,0,0,0,0,0,0,'Daisy - On Script - Say Line 1 (Fobeed)'),
(450700,9,7,0,0,0,100,0,0,0,0,0,0,80,425101,2,0,0,0,0,10,21680,4251,0,0,0,0,0,0,'Daisy - On Script - Call Action List (Goblin Racer)'),
(450700,9,8,0,0,0,100,0,0,0,0,0,0,80,425201,2,0,0,0,0,10,21682,4252,0,0,0,0,0,0,'Daisy - On Script - Call Action List (Gnome Racer)'),
(450700,9,9,0,0,0,100,0,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Daisy - On Script - Set Phase 1'),

(450701,9,0,0,0,0,100,0,30000,30000,0,0,0,53,0,450700,0,0,0,0,1,0,0,0,0,0,0,0,0,'Daisy - On Script - Start Waypoint Movement'),
(450701,9,1,0,0,0,100,0,8000,8000,0,0,0,66,10000,0,0,0,0,0,8,0,0,0,0,0,0,0,1.60989,'Daisy - On Script - Set Orientation'),
(450701,9,2,0,0,0,100,0,600000,600000,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Daisy - On Script - Force Despawn'),

-- Goblin Racer
(4251,0,0,0,40,1,10,0,0,0,0,0,0,87,425103,425104,0,0,0,0,1,0,0,0,0,0,0,0,0,'Goblin Racer - On Waypoint Reached (Phase 1) - Call Random Action List'),
(4251,0,1,0,58,1,100,0,0,425101,0,0,0,80,425102,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Goblin Racer - On Waypoint Path Ended (Phase 1) - Call Action List'),

(425100,9,0,0,0,0,100,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Goblin Racer - On Script - Set Active On'),
(425100,9,1,0,0,0,100,0,0,0,0,0,0,53,0,425100,0,0,0,0,1,0,0,0,0,0,0,0,0,'Goblin Racer - On Script - Start Waypoint Movement'),

(425101,9,0,0,0,0,100,0,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Goblin Racer - On Script - Set Phase 1'),
(425101,9,1,0,0,0,100,0,0,0,0,0,0,53,1,425101,0,0,0,0,1,0,0,0,0,0,0,0,0,'Goblin Racer - On Script - Start Waypoint Movement'),

(425102,9,0,0,0,0,100,0,0,0,0,0,0,45,1,1,0,0,0,0,10,21681,4507,0,0,0,0,0,0,'Goblin Racer - On Script - Set Data 1 1 (Daisy)'),
(425102,9,1,0,0,0,100,0,0,0,0,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Goblin Racer - On Script - Set Phase 2'),
(425102,9,2,0,0,0,100,0,0,0,0,0,0,86,7035,0,10,21681,4507,0,1,0,0,0,0,0,0,0,0,'Goblin Racer - On Script - Cross Cast ''Goblin Racer Cheer'' (Daisy)'),
(425102,9,3,0,0,0,100,0,0,0,0,0,0,53,1,425102,0,0,0,0,1,0,0,0,0,0,0,0,0,'Goblin Racer - On Script - Start Waypoint Movement'),
(425102,9,4,0,0,0,100,0,4000,4000,0,0,0,11,60081,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Goblin Racer - On Script - Cast ''Cosmetic - Explosion'''),
(425102,9,5,0,0,0,100,0,1000,1000,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Goblin Racer - On Script - Force Despawn'),

(425103,9,0,0,0,0,100,0,0,0,0,0,0,11,6600,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Goblin Racer - On Script - Cast Spell ''Salt Flats Racer Speed'''),
(425104,9,0,0,0,0,100,0,0,0,0,0,0,11,6601,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Goblin Racer - On Script - Cast Spell ''Salt Flats Racer Slow'''),

-- Gnome Racer
(4252,0,0,0,40,1,10,0,0,0,0,0,0,87,425203,425204,0,0,0,0,1,0,0,0,0,0,0,0,0,'Gnome Racer - On Waypoint Reached (Phase 1) - Call Random Action List'),
(4252,0,1,0,58,1,100,0,0,425201,0,0,0,80,425202,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Gnome Racer - On Waypoint Path Ended (Phase 1) - Call Action List'),

(425200,9,0,0,0,0,100,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Gnome Racer - On Script - Set Active On'),
(425200,9,1,0,0,0,100,0,0,0,0,0,0,53,0,425200,0,0,0,0,1,0,0,0,0,0,0,0,0,'Gnome Racer - On Script - Start Waypoint Movement'),

(425201,9,0,0,0,0,100,0,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Gnome Racer - On Script - Set Phase 1'),
(425201,9,1,0,0,0,100,0,0,0,0,0,0,53,1,425201,0,0,0,0,1,0,0,0,0,0,0,0,0,'Gnome Racer - On Script - Start Waypoint Movement'),

(425202,9,0,0,0,0,100,0,0,0,0,0,0,45,1,2,0,0,0,0,10,21681,4507,0,0,0,0,0,0,'Gnome Racer - On Script - Set Data 1 2 (Daisy)'),
(425202,9,1,0,0,0,100,0,0,0,0,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Gnome Racer - On Script - Set Phase 2'),
(425202,9,2,0,0,0,100,0,0,0,0,0,0,86,7036,0,10,21681,4507,0,1,0,0,0,0,0,0,0,0,'Gnome Racer - On Script - Cross Cast ''Gnome Racer Cheer'' (Daisy)'),
(425202,9,3,0,0,0,100,0,0,0,0,0,0,53,1,425202,0,0,0,0,1,0,0,0,0,0,0,0,0,'Gnome Racer - On Script - Start Waypoint Movement'),
(425202,9,4,0,0,0,100,0,4000,4000,0,0,0,11,60081,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Gnome Racer - On Script - Cast ''Cosmetic - Explosion'''),
(425202,9,5,0,0,0,100,0,1000,1000,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Gnome Racer - On Script - Force Despawn'),

(425203,9,0,0,0,0,100,0,0,0,0,0,0,11,6600,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Gnome Racer - On Script - Cast Spell ''Salt Flats Racer Speed'''),
(425204,9,0,0,0,0,100,0,0,0,0,0,0,11,6601,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Gnome Racer - On Script - Cast Spell ''Salt Flats Racer Slow''');

DELETE FROM `waypoints` WHERE `entry` IN (425100,425101,425102,425200,425201,425202,450700);
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`)
VALUES
-- Goblin Racer roll to start line
(425100,1,-6225.51,-3941.11,-58.7498,''),
(425100,2,-6236.21,-3935.4,-58.7498,''),
(425100,3,-6247.18,-3931.45,-58.7498,''),
(425100,4,-6258.18,-3927.22,-58.7498,''),
(425100,5,-6269.23,-3923.11,-58.7547,''),
(425100,6,-6279.39,-3918.62,-59.3734,''),
(425100,7,-6282.4,-3913.51,-60.9864,''),
(425100,8,-6281.27,-3907.82,-62.2515,''),
(425100,9,-6275.9,-3905.8,-62.1365,''),
(425100,10,-6263.77,-3905.9,-61.6845,''),
(425100,11,-6253.39,-3906.03,-61.3059,''),
(425100,12,-6239.63,-3906.45,-60.7614,''),
(425100,13,-6225.17,-3906.85,-60.5172,''),
(425100,14,-6210.59,-3906.98,-60.3689,''),
(425100,15,-6199.5,-3906.93,-60.2643,''),

-- Goblin Racer racing
(425101,1,-6191.34,-3907.16,-60.1596,''),
(425101,2,-6182.71,-3907.32,-60.0754,''),
(425101,3,-6173.72,-3907.54,-59.989,''),
(425101,4,-6165.55,-3907.61,-59.9135,''),
(425101,5,-6157.03,-3907.58,-59.8541,''),
(425101,6,-6149.33,-3907.56,-59.869,''),
(425101,7,-6141.87,-3907.27,-59.8809,''),
(425101,8,-6134.19,-3906.66,-59.8966,''),
(425101,9,-6126.41,-3906,-59.9151,''),
(425101,10,-6118.21,-3904.83,-59.9276,''),
(425101,11,-6109.64,-3903.1,-59.9142,''),
(425101,12,-6101.99,-3900.99,-59.8983,''),
(425101,13,-6094.14,-3898.34,-59.9102,''),
(425101,14,-6086.04,-3895.35,-59.9533,''),
(425101,15,-6078.54,-3892.43,-60.0029,''),
(425101,16,-6071.29,-3889.5,-60.0037,''),
(425101,17,-6064.36,-3886.7,-60.0814,''),
(425101,18,-6056.71,-3883.55,-60.0903,''),
(425101,19,-6048.43,-3880.06,-60.0819,''),
(425101,20,-6041.12,-3876.97,-60.2107,''),
(425101,21,-6033.99,-3873.77,-60.2425,''),
(425101,22,-6026.41,-3870.14,-60.3019,''),
(425101,23,-6018.84,-3866.51,-60.3987,''),
(425101,24,-6010.52,-3862.53,-60.463,''),
(425101,25,-6001.92,-3858.92,-60.4977,''),
(425101,26,-5994,-3855.5,-60.537,''),
(425101,27,-5986.28,-3852.17,-60.5544,''),
(425101,28,-5977.79,-3848.58,-60.6569,''),
(425101,29,-5969.48,-3845.51,-60.6788,''),
(425101,30,-5961.47,-3842.31,-60.6862,''),
(425101,31,-5953.81,-3838.1,-60.7637,''),
(425101,32,-5946.88,-3833.78,-60.7016,''),
(425101,33,-5939.37,-3828.83,-60.5285,''),
(425101,34,-5932.05,-3824.73,-60.3301,''),
(425101,35,-5924.41,-3820.69,-60.1505,''),
(425101,36,-5916.7,-3816.31,-59.9721,''),
(425101,37,-5908.94,-3811.77,-59.7802,''),
(425101,38,-5901.17,-3807.78,-59.599,''),
(425101,39,-5892.77,-3803.96,-59.7475,''),
(425101,40,-5884.03,-3800.4,-59.9015,''),
(425101,41,-5875.09,-3797.35,-59.7717,''),
(425101,42,-5866.7,-3794.49,-59.9663,''),
(425101,43,-5857.66,-3791.74,-60.0965,''),
(425101,44,-5848.34,-3789.6,-60.2175,''),
(425101,45,-5838.75,-3788.36,-60.7136,''),
(425101,46,-5829.42,-3788.33,-61.4276,''),
(425101,47,-5819.15,-3788.47,-61.2672,''),
(425101,48,-5808.65,-3788.6,-61.2449,''),
(425101,49,-5799.44,-3788.72,-61.4032,''),
(425101,50,-5790.11,-3788.86,-61.5079,''),
(425101,51,-5780.1,-3789.52,-61.7291,''),
(425101,52,-5770.1,-3790.31,-61.6892,''),
(425101,53,-5760.91,-3791.05,-61.4138,''),
(425101,54,-5751.14,-3791.82,-61.2425,''),
(425101,55,-5741.44,-3793.19,-60.7875,''),
(425101,56,-5731.58,-3795.02,-60.5013,''),
(425101,57,-5722.71,-3797.45,-60.7248,''),
(425101,58,-5714.12,-3801.59,-60.7033,''),
(425101,59,-5705.75,-3807.33,-61.276,''),
(425101,60,-5698.13,-3813.49,-61.5311,''),
(425101,61,-5690.2,-3821.38,-61.8514,''),
(425101,62,-5683.57,-3828.12,-62.058,''),
(425101,63,-5676.96,-3836.11,-62.4184,''),
(425101,64,-5672.08,-3844.19,-62.5536,''),
(425101,65,-5667.64,-3852.92,-62.3648,''),
(425101,66,-5663.64,-3861.98,-62.1911,''),
(425101,67,-5660.23,-3870.42,-62.0313,''),
(425101,68,-5656.72,-3879.57,-61.9076,''),
(425101,69,-5653.92,-3888.84,-61.8135,''),
(425101,70,-5652.15,-3898.59,-61.7162,''),
(425101,71,-5651.03,-3908.67,-61.5772,''),
(425101,72,-5650.91,-3918.93,-61.4799,''),
(425101,73,-5651.61,-3929.06,-61.3575,''),
(425101,74,-5652.3,-3939.18,-61.2442,''),
(425101,75,-5652.61,-3949.91,-61.1983,''),
(425101,76,-5652.73,-3960.29,-61.1905,''),
(425101,77,-5652.62,-3969.86,-61.1821,''),
(425101,78,-5652.49,-3980,-61.1733,''),
(425101,79,-5652.18,-3989.45,-61.1665,''),
(425101,80,-5651.97,-3999,-61.1476,''),
(425101,81,-5652.08,-4007.87,-61.1334,''),
(425101,82,-5652.02,-4017.67,-61.138,''),
(425101,83,-5651.95,-4027.7,-61.1301,''),
(425101,84,-5651.95,-4037.85,-61.1205,''),
(425101,85,-5652.04,-4048.35,-61.1178,''),
(425101,86,-5652.13,-4058.26,-61.198,''),
(425101,87,-5652.52,-4068.28,-61.2569,''),
(425101,88,-5652.11,-4077.77,-61.325,''),
(425101,89,-5651.96,-4088.15,-61.4121,''),
(425101,90,-5652.17,-4098.18,-61.4581,''),
(425101,91,-5654.03,-4107.79,-61.4934,''),
(425101,92,-5657.23,-4117.03,-61.52,''),
(425101,93,-5661.96,-4126.92,-61.5754,''),
(425101,94,-5667.81,-4136.45,-61.6158,''),
(425101,95,-5674.38,-4145.07,-61.4887,''),
(425101,96,-5681.9,-4152.55,-61.1095,''),
(425101,97,-5689.64,-4159.46,-60.7022,''),
(425101,98,-5697.77,-4165.15,-60.3832,''),
(425101,99,-5707.17,-4170.99,-60.7134,''),
(425101,100,-5717.18,-4175.44,-60.9908,''),
(425101,101,-5727.36,-4179.17,-61.2624,''),
(425101,102,-5738.05,-4182.49,-61.3718,''),
(425101,103,-5749.12,-4185.79,-61.4358,''),
(425101,104,-5760.01,-4188.84,-61.4949,''),
(425101,105,-5771,-4191.55,-61.5739,''),
(425101,106,-5782.2,-4193.87,-61.4574,''),
(425101,107,-5793.75,-4195.5,-61.2659,''),
(425101,108,-5804.87,-4196.79,-61.4307,''),
(425101,109,-5816.49,-4197.87,-61.7136,''),
(425101,110,-5827.89,-4198.71,-61.9537,''),
(425101,111,-5838.83,-4199.43,-62.2257,''),
(425101,112,-5860.84,-4200.84,-62.6325,''),
(425101,113,-5871.57,-4201.42,-62.6989,''),
(425101,114,-5882.64,-4202.02,-62.7864,''),
(425101,115,-5892.89,-4202.57,-62.8554,''),
(425101,116,-5904.42,-4203.16,-62.9321,''),
(425101,117,-5915.38,-4203.5,-62.8121,''),
(425101,118,-5925.06,-4203.69,-62.6909,''),
(425101,119,-5935.91,-4203.8,-62.5702,''),
(425101,120,-5946.41,-4203.92,-62.4459,''),
(425101,121,-5956.56,-4203.88,-62.3288,''),
(425101,122,-5967.76,-4203.6,-62.2098,''),
(425101,123,-5978.13,-4203.21,-62.2635,''),
(425101,124,-5988.37,-4202.45,-62.3194,''),
(425101,125,-5999.3,-4201.53,-62.3791,''),
(425101,126,-6009.4,-4200.55,-62.4333,''),
(425101,127,-6019.49,-4199.46,-62.5019,''),
(425101,128,-6030.61,-4198.15,-62.561,''),
(425101,129,-6041.04,-4196.91,-62.6382,''),
(425101,130,-6051.82,-4195.7,-62.6637,''),
(425101,131,-6061.92,-4194.74,-62.4942,''),
(425101,132,-6072.04,-4193.86,-62.2556,''),
(425101,133,-6082.05,-4193.19,-62.0819,''),
(425101,134,-6090.91,-4192.73,-62.0193,''),
(425101,135,-6101.39,-4192.19,-62.2437,''),
(425101,136,-6111.76,-4191.65,-62.4711,''),
(425101,137,-6121.08,-4191.3,-62.6608,''),
(425101,138,-6132.16,-4191.27,-62.4196,''),
(425101,139,-6142.66,-4191.63,-62.1792,''),
(425101,140,-6152.66,-4192.38,-61.9736,''),
(425101,141,-6163.01,-4193.25,-61.7382,''),
(425101,142,-6173,-4194.25,-61.7186,''),
(425101,143,-6183.19,-4195.51,-61.6798,''),
(425101,144,-6194.04,-4197.1,-61.656,''),
(425101,145,-6204.15,-4198.82,-61.6283,''),
(425101,146,-6214.13,-4200.68,-61.5886,''),
(425101,147,-6224.52,-4203.34,-61.6324,''),
(425101,148,-6234.1,-4205.92,-61.6652,''),
(425101,149,-6244.13,-4208.61,-61.7164,''),
(425101,150,-6254.01,-4210.92,-61.7196,''),
(425101,151,-6263.09,-4212.42,-61.6526,''),
(425101,152,-6272.89,-4213.83,-61.57,''),
(425101,153,-6283.78,-4215.15,-61.4885,''),
(425101,154,-6293.67,-4215.9,-61.4038,''),
(425101,155,-6302.76,-4215.79,-61.3312,''),
(425101,156,-6312.99,-4214.93,-61.7428,''),
(425101,157,-6323.21,-4213.14,-62.2589,''),
(425101,158,-6332.36,-4211.33,-62.8202,''),
(425101,159,-6340.83,-4209.17,-62.4751,''),
(425101,160,-6348.46,-4205.71,-61.8554,''),
(425101,161,-6356.22,-4200.75,-61.2628,''),
(425101,162,-6363.98,-4194.96,-61.3468,''),
(425101,163,-6371.92,-4188.64,-61.855,''),
(425101,164,-6379.53,-4182.48,-62.2341,''),
(425101,165,-6387.53,-4175.85,-62.655,''),
(425101,166,-6394.59,-4168.89,-62.8009,''),
(425101,167,-6400.52,-4161.42,-63.097,''),
(425101,168,-6404.69,-4152.82,-63.3336,''),
(425101,169,-6408.46,-4143.78,-63.5631,''),
(425101,170,-6412.27,-4134.38,-63.8068,''),
(425101,171,-6415.74,-4124.6,-63.6947,''),
(425101,172,-6418.75,-4114.66,-63.841,''),
(425101,173,-6421.09,-4104.91,-63.7418,''),
(425101,174,-6423.35,-4094.54,-63.688,''),
(425101,175,-6425.45,-4084.97,-63.5708,''),
(425101,176,-6426.82,-4075.04,-63.2059,''),
(425101,177,-6427.49,-4064.33,-63.4149,''),
(425101,178,-6427.68,-4054.65,-63.3226,''),
(425101,179,-6427.67,-4044.38,-63.2196,''),
(425101,180,-6427.39,-4034.11,-63.1251,''),
(425101,181,-6427.07,-4024.21,-63.0233,''),
(425101,182,-6426.55,-4015.01,-62.9283,''),
(425101,183,-6425.56,-4004.91,-62.8437,''),
(425101,184,-6424.53,-3995.99,-62.8444,''),
(425101,185,-6423.09,-3986.18,-62.8394,''),
(425101,186,-6421.28,-3975.36,-62.8359,''),
(425101,187,-6418.93,-3966.08,-62.8326,''),
(425101,188,-6416.2,-3956.43,-62.8061,''),
(425101,189,-6412.62,-3946.94,-62.6365,''),
(425101,190,-6407.84,-3937.73,-62.266,''),
(425101,191,-6401.56,-3927.91,-61.9102,''),
(425101,192,-6395.28,-3919.51,-61.6526,''),
(425101,193,-6387.85,-3911.94,-61.6891,''),
(425101,194,-6379.98,-3906.36,-61.8822,''),
(425101,195,-6371.86,-3902.53,-62.0803,''),
(425101,196,-6362.79,-3900.35,-62.2368,''),
(425101,197,-6352.99,-3898.99,-62.3269,''),
(425101,198,-6343.68,-3899.36,-62.4514,''),
(425101,199,-6333.33,-3900.22,-62.5877,''),
(425101,200,-6322.52,-3901.13,-62.8141,''),
(425101,201,-6311.36,-3902.06,-62.9706,''),
(425101,202,-6300.37,-3902.95,-63.1136,''),
(425101,203,-6289.89,-3903.6,-62.7118,''),
(425101,204,-6280.23,-3904.21,-62.3654,''),
(425101,205,-6270.45,-3904.84,-61.9714,''),
(425101,206,-6261.94,-3905.18,-61.6432,''),
(425101,207,-6253.55,-3905.48,-61.3237,''),
(425101,208,-6244.92,-3905.8,-60.9986,''),
(425101,209,-6236.54,-3906.1,-60.6798,''),
(425101,210,-6227.33,-3906.44,-60.5224,''),
(425101,211,-6218.47,-3906.77,-60.4412,''),
(425101,212,-6210.65,-3907.06,-60.3711,''),
(425101,213,-6199.5,-3906.93,-60.2643,''),

-- Goblin Racer finish
(425102,1,-6188.01,-3907.96,-60.1272,''),
(425102,2,-6177.6,-3906.84,-60.0201,''),
(425102,3,-6168.58,-3905.66,-59.9351,''),
(425102,4,-6157.99,-3907.73,-59.853,''),
(425102,5,-6148.83,-3908.73,-59.8512,''),
(425102,6,-6138.93,-3906.71,-59.8883,''),
(425102,7,-6129.07,-3906.8,-59.9096,''),
(425102,8,-6119.94,-3905.93,-59.9228,''),

-- Gnome Racer roll to start line
(425200,1,-6213.07,-3849.85,-58.7497,''),
(425200,2,-6213.32,-3859.06,-58.7497,''),
(425200,3,-6215.83,-3866.94,-58.7497,''),
(425200,4,-6221.18,-3875.85,-58.7497,''),
(425200,5,-6230.55,-3880.74,-58.8272,''),
(425200,6,-6240.48,-3881.41,-59.0274,''),
(425200,7,-6253.07,-3881.06,-59.0491,''),
(425200,8,-6261.79,-3882.39,-59.2914,''),
(425200,9,-6268.24,-3885.55,-60.3912,''),
(425200,10,-6271.64,-3890.09,-61.6989,''),
(425200,11,-6271.71,-3895.41,-62.0288,''),
(425200,12,-6266.81,-3897.27,-61.8543,''),
(425200,13,-6256.8,-3897.43,-61.4237,''),
(425200,14,-6245.13,-3897.58,-61.0156,''),
(425200,15,-6231.72,-3897.77,-60.5649,''),
(425200,16,-6217.37,-3897.85,-60.4397,''),
(425200,17,-6207.68,-3897.86,-60.3485,''),
(425200,18,-6200.45,-3897.66,-60.2832,''),

-- Gnome Racer racing
(425201,1,-6191.13,-3897.99,-60.1547,''),
(425201,2,-6183.44,-3898.16,-60.0868,''),
(425201,3,-6174.8,-3898.45,-60.0056,''),
(425201,4,-6165.49,-3898.95,-59.9097,''),
(425201,5,-6156.97,-3899.07,-59.8555,''),
(425201,6,-6148.45,-3898.89,-59.8717,''),
(425201,7,-6140.53,-3898.68,-59.8844,''),
(425201,8,-6132.61,-3898.29,-59.9057,''),
(425201,9,-6124.03,-3897.38,-59.9139,''),
(425201,10,-6115.28,-3895.98,-59.949,''),
(425201,11,-6106.84,-3893.7,-59.9951,''),
(425201,12,-6098.68,-3891.24,-60.0377,''),
(425201,13,-6090.25,-3888.54,-60.0788,''),
(425201,14,-6081.56,-3885.46,-60.1355,''),
(425201,15,-6072.5,-3882.04,-60.1736,''),
(425201,16,-6064.86,-3879.16,-60.2146,''),
(425201,17,-6056.94,-3876.05,-60.2663,''),
(425201,18,-6049.15,-3872.9,-60.2967,''),
(425201,19,-6041.14,-3869.67,-60.3445,''),
(425201,20,-6032.96,-3866.25,-60.3929,''),
(425201,21,-6024.91,-3862.81,-60.4201,''),
(425201,22,-6017.94,-3859.83,-60.4674,''),
(425201,23,-6010.55,-3856.64,-60.5121,''),
(425201,24,-6002.64,-3853.19,-60.5419,''),
(425201,25,-5994.61,-3849.69,-60.5862,''),
(425201,26,-5986.62,-3846.13,-60.6333,''),
(425201,27,-5978.73,-3842.61,-60.6723,''),
(425201,28,-5970.21,-3838.81,-60.7158,''),
(425201,29,-5961.54,-3834.75,-60.7743,''),
(425201,30,-5953.2,-3828.76,-60.6922,''),
(425201,31,-5944.69,-3822.82,-60.4692,''),
(425201,32,-5936.07,-3817.66,-60.2527,''),
(425201,33,-5926.36,-3812.3,-60.0549,''),
(425201,34,-5917.03,-3807.91,-59.7889,''),
(425201,35,-5906.75,-3802.67,-59.591,''),
(425201,36,-5895.76,-3797.51,-59.7463,''),
(425201,37,-5886.58,-3793.77,-60.0257,''),
(425201,38,-5876.67,-3790.31,-60.1595,''),
(425201,39,-5866.79,-3786.6,-60.2363,''),
(425201,40,-5856.81,-3782.17,-60.7624,''),
(425201,41,-5847.81,-3780.26,-60.9771,''),
(425201,42,-5838.69,-3777.91,-61.0963,''),
(425201,43,-5828.99,-3776.57,-61.1453,''),
(425201,44,-5817.79,-3776.7,-61.2493,''),
(425201,45,-5808.22,-3776.95,-61.3142,''),
(425201,46,-5799.27,-3777.61,-61.4031,''),
(425201,47,-5788.73,-3778.89,-61.4787,''),
(425201,48,-5779.45,-3779.9,-61.5685,''),
(425201,49,-5770.86,-3781.42,-61.6462,''),
(425201,50,-5761.83,-3783.77,-61.7109,''),
(425201,51,-5752.74,-3785.92,-61.4701,''),
(425201,52,-5744.52,-3787.46,-61.3502,''),
(425201,53,-5735.69,-3789.1,-61.0581,''),
(425201,54,-5727.33,-3792.11,-60.9136,''),
(425201,55,-5718.91,-3797.02,-60.6031,''),
(425201,56,-5711.88,-3802.96,-60.9495,''),
(425201,57,-5704.67,-3810.75,-61.4076,''),
(425201,58,-5698.32,-3818.22,-61.6877,''),
(425201,59,-5692.7,-3825.67,-62.0049,''),
(425201,60,-5687.31,-3833.29,-62.2746,''),
(425201,61,-5683.05,-3839.84,-62.4105,''),
(425201,62,-5679.18,-3846.37,-62.5762,''),
(425201,63,-5675.19,-3854.28,-62.3824,''),
(425201,64,-5671.32,-3862.26,-62.2226,''),
(425201,65,-5667.59,-3870.17,-62.0706,''),
(425201,66,-5664.63,-3877.78,-61.9482,''),
(425201,67,-5662.53,-3886.03,-61.839,''),
(425201,68,-5660.7,-3894.46,-61.7547,''),
(425201,69,-5659.71,-3903.38,-61.622,''),
(425201,70,-5659,-3912.57,-61.528,''),
(425201,71,-5657.93,-3921.85,-61.4457,''),
(425201,72,-5656.73,-3930.87,-61.3267,''),
(425201,73,-5655.31,-3940.45,-61.2273,''),
(425201,74,-5653.95,-3949.8,-61.1983,''),
(425201,75,-5652.19,-3959.55,-61.191,''),
(425201,76,-5650.45,-3968.72,-61.1827,''),
(425201,77,-5648.88,-3977.56,-61.1758,''),
(425201,78,-5645.48,-3987.04,-61.1671,''),
(425201,79,-5643.65,-3995.95,-61.1594,''),
(425201,80,-5642.07,-4005.56,-61.1477,''),
(425201,81,-5640.9,-4015.18,-61.1393,''),
(425201,82,-5640.18,-4024.48,-61.1313,''),
(425201,83,-5639.49,-4033.56,-61.1239,''),
(425201,84,-5638.75,-4043.8,-61.1163,''),
(425201,85,-5638.62,-4052.55,-61.1497,''),
(425201,86,-5638.78,-4061.89,-61.2196,''),
(425201,87,-5640.51,-4072.33,-61.2885,''),
(425201,88,-5643.95,-4082.94,-61.3682,''),
(425201,89,-5647.96,-4091.97,-61.4318,''),
(425201,90,-5652.74,-4099.73,-61.4644,''),
(425201,91,-5658.15,-4108.15,-61.5069,''),
(425201,92,-5663.05,-4116.77,-61.547,''),
(425201,93,-5668.11,-4125.02,-61.5868,''),
(425201,94,-5673.62,-4133.69,-61.6279,''),
(425201,95,-5679.39,-4141.17,-61.5546,''),
(425201,96,-5685.81,-4147.76,-61.2686,''),
(425201,97,-5693.73,-4153.52,-60.805,''),
(425201,98,-5702.2,-4158.68,-60.38,''),
(425201,99,-5711.17,-4163.68,-60.5767,''),
(425201,100,-5719.97,-4167.7,-60.7495,''),
(425201,101,-5728.91,-4171.09,-60.9849,''),
(425201,102,-5738.42,-4174.28,-61.3725,''),
(425201,103,-5747.66,-4176.74,-61.4211,''),
(425201,104,-5757.03,-4179.17,-61.4857,''),
(425201,105,-5766.08,-4181.43,-61.5319,''),
(425201,106,-5775.63,-4183.64,-61.523,''),
(425201,107,-5785.16,-4185.34,-61.3824,''),
(425201,108,-5794.63,-4186.67,-61.2606,''),
(425201,109,-5804.93,-4187.97,-61.3876,''),
(425201,110,-5814.68,-4188.93,-61.6206,''),
(425201,111,-5824.68,-4189.75,-61.8774,''),
(425201,112,-5833.86,-4190.43,-62.1073,''),
(425201,113,-5842.48,-4191,-62.3082,''),
(425201,114,-5851.21,-4191.57,-62.5253,''),
(425201,115,-5861.32,-4192.4,-62.6363,''),
(425201,116,-5871.21,-4193.24,-62.6999,''),
(425201,117,-5880.64,-4193.85,-62.7766,''),
(425201,118,-5889.84,-4194.21,-62.8327,''),
(425201,119,-5898.47,-4194.51,-62.8894,''),
(425201,120,-5907.67,-4194.83,-62.8819,''),
(425201,121,-5916.77,-4195.14,-62.7659,''),
(425201,122,-5926.44,-4195.48,-62.6792,''),
(425201,123,-5936.36,-4195.62,-62.5624,''),
(425201,124,-5945.7,-4195.7,-62.4532,''),
(425201,125,-5955.38,-4195.71,-62.3407,''),
(425201,126,-5965.41,-4195.57,-62.2259,''),
(425201,127,-5975.91,-4195.54,-62.2551,''),
(425201,128,-5986.3,-4195.46,-62.3111,''),
(425201,129,-5996.9,-4195.03,-62.3646,''),
(425201,130,-6006.44,-4194.28,-62.4284,''),
(425201,131,-6015.97,-4193.45,-62.4367,''),
(425201,132,-6025.38,-4192.59,-62.5398,''),
(425201,133,-6034.45,-4191.69,-62.5892,''),
(425201,134,-6043.49,-4190.67,-62.6533,''),
(425201,135,-6053.09,-4189.39,-62.6578,''),
(425201,136,-6063.16,-4188.11,-62.4733,''),
(425201,137,-6072.55,-4187.03,-62.2856,''),
(425201,138,-6082.19,-4186.11,-62.0776,''),
(425201,139,-6092.67,-4185.46,-62.051,''),
(425201,140,-6103.04,-4184.89,-62.2653,''),
(425201,141,-6113.42,-4184.63,-62.4858,''),
(425201,142,-6124.15,-4184.92,-62.6071,''),
(425201,143,-6134.52,-4185.2,-62.3842,''),
(425201,144,-6145.36,-4185.69,-62.1294,''),
(425201,145,-6155.71,-4186.58,-61.9095,''),
(425201,146,-6166.17,-4187.48,-61.7304,''),
(425201,147,-6177.33,-4188.44,-61.696,''),
(425201,148,-6185.81,-4189.2,-61.6767,''),
(425201,149,-6195.39,-4190.63,-61.6506,''),
(425201,150,-6205.03,-4192.38,-61.6175,''),
(425201,151,-6214.78,-4194.21,-61.5961,''),
(425201,152,-6224.48,-4196.3,-61.6135,''),
(425201,153,-6233.62,-4198.14,-61.6568,''),
(425201,154,-6242.89,-4199.97,-61.6911,''),
(425201,155,-6252.97,-4201.97,-61.7273,''),
(425201,156,-6262.82,-4203.9,-61.6297,''),
(425201,157,-6273.05,-4205.66,-61.5693,''),
(425201,158,-6282.99,-4206.99,-61.4881,''),
(425201,159,-6294.46,-4208.37,-61.3831,''),
(425201,160,-6304.92,-4209.25,-61.3155,''),
(425201,161,-6316.44,-4210.08,-61.9332,''),
(425201,162,-6328.2,-4210.85,-62.4794,''),
(425201,163,-6338.91,-4211.56,-62.6251,''),
(425201,164,-6348.49,-4210.64,-62.0232,''),
(425201,165,-6356.92,-4207.3,-61.6654,''),
(425201,166,-6364.13,-4202.14,-61.1157,''),
(425201,167,-6371.33,-4196.2,-61.4884,''),
(425201,168,-6378.78,-4189.83,-61.7792,''),
(425201,169,-6385.96,-4183.68,-62.2433,''),
(425201,170,-6393.2,-4176.92,-62.6041,''),
(425201,171,-6399.35,-4170.36,-62.9947,''),
(425201,172,-6404.76,-4162.21,-63.22,''),
(425201,173,-6409.01,-4154.56,-63.3792,''),
(425201,174,-6412.76,-4146.4,-63.5873,''),
(425201,175,-6416.19,-4138.1,-63.8013,''),
(425201,176,-6419.27,-4129.67,-64.0044,''),
(425201,177,-6421.97,-4120.87,-64.0823,''),
(425201,178,-6424.7,-4111.7,-63.9544,''),
(425201,179,-6427.14,-4102.09,-63.8454,''),
(425201,180,-6429.14,-4092.39,-63.739,''),
(425201,181,-6430.8,-4082.72,-63.6193,''),
(425201,182,-6431.55,-4072.96,-63.5013,''),
(425201,183,-6431.81,-4063.41,-63.4091,''),
(425201,184,-6432.07,-4053.72,-63.3199,''),
(425201,185,-6432.12,-4044.15,-63.2197,''),
(425201,186,-6432.02,-4034.24,-63.1279,''),
(425201,187,-6431.8,-4023.63,-63.0207,''),
(425201,188,-6431.49,-4013.71,-62.927,''),
(425201,189,-6431.01,-4004.51,-62.8465,''),
(425201,190,-6429.68,-3994.92,-62.8435,''),
(425201,191,-6428,-3984.32,-62.8388,''),
(425201,192,-6425.7,-3974.44,-62.8355,''),
(425201,193,-6423.12,-3964.14,-62.8313,''),
(425201,194,-6420.24,-3954.9,-62.8263,''),
(425201,195,-6416.66,-3945.65,-62.6458,''),
(425201,196,-6412.34,-3937.4,-62.5412,''),
(425201,197,-6406.42,-3928.75,-62.1537,''),
(425201,198,-6398.58,-3922.15,-61.7519,''),
(425201,199,-6389.51,-3916.89,-61.5696,''),
(425201,200,-6380.43,-3912.63,-61.7523,''),
(425201,201,-6370.58,-3909.01,-61.9721,''),
(425201,202,-6360.86,-3906.08,-62.2233,''),
(425201,203,-6351.73,-3903.65,-62.3375,''),
(425201,204,-6342.71,-3901.26,-62.4708,''),
(425201,205,-6333.07,-3898.94,-62.5955,''),
(425201,206,-6322.43,-3897.58,-62.822,''),
(425201,207,-6312.65,-3897.02,-62.939,''),
(425201,208,-6302.74,-3896.83,-63.0881,''),
(425201,209,-6293.4,-3896.73,-62.8319,''),
(425201,210,-6283.84,-3896.64,-62.4841,''),
(425201,211,-6274.15,-3896.57,-62.109,''),
(425201,212,-6263.76,-3896.5,-61.7205,''),
(425201,213,-6253.84,-3896.48,-61.3577,''),
(425201,214,-6243.23,-3896.49,-60.9442,''),
(425201,215,-6233.32,-3896.47,-60.5944,''),
(425201,216,-6222.59,-3896.66,-60.4868,''),
(425201,217,-6213.38,-3896.88,-60.3687,''),
(425201,218,-6200.45,-3897.66,-60.2832,''),

-- Gnome Racer finish
(425202,1,-6190.65,-3896.22,-60.1529,''),
(425202,2,-6180.66,-3896.07,-60.0595,''),
(425202,3,-6171.55,-3897.96,-59.9696,''),
(425202,4,-6161.52,-3896.79,-59.8741,''),
(425202,5,-6151.06,-3897.01,-59.8661,''),
(425202,6,-6141.54,-3898.68,-59.8809,''),
(425202,7,-6132.44,-3897.03,-59.9045,''),
(425202,8,-6117.72,-3893.62,-59.9211,''),

-- Daisy walk away
(450700,1,-6181.54,-3901.89,-60.0522,''),
(450700,2,-6181.91,-3906.66,-60.0592,''),
(450700,3,-6182.58,-3912.22,-59.9758,''),
(450700,4,-6182.4,-3917.94,-58.8287,'');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
