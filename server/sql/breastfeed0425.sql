/*
 Navicat Premium Data Transfer

 Source Server         : local_database
 Source Server Type    : MySQL
 Source Server Version : 80014
 Source Host           : localhost:3306
 Source Schema         : breastfeed

 Target Server Type    : MySQL
 Target Server Version : 80014
 File Encoding         : 65001

 Date: 25/04/2022 01:38:36
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for administrator
-- ----------------------------
DROP TABLE IF EXISTS `administrator`;
CREATE TABLE `administrator`  (
  `administrator_id` int(11) NOT NULL AUTO_INCREMENT,
  `administrator_name` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `administrator_password` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `administrator_right` int(11) NOT NULL,
  `administrator_token` char(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  PRIMARY KEY (`administrator_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of administrator
-- ----------------------------

-- ----------------------------
-- Table structure for answer
-- ----------------------------
DROP TABLE IF EXISTS `answer`;
CREATE TABLE `answer`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `t_id` int(11) NOT NULL COMMENT '问卷id',
  `answers` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '问卷选择',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 51 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '问卷选项' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of answer
-- ----------------------------
INSERT INTO `answer` VALUES (1, 9, 1, 'C.70cm|');
INSERT INTO `answer` VALUES (2, 9, 1, 'D.38|');
INSERT INTO `answer` VALUES (3, 9, 1, 'B.60cm|');
INSERT INTO `answer` VALUES (4, 9, 1, 'C.36|');
INSERT INTO `answer` VALUES (5, 9, 1, 'B.60cm|');
INSERT INTO `answer` VALUES (6, 9, 1, 'B.31|');
INSERT INTO `answer` VALUES (7, 9, 1, 'B.60cm|');
INSERT INTO `answer` VALUES (8, 9, 1, 'B.31|');
INSERT INTO `answer` VALUES (9, 9, 1, 'A.30cm|');
INSERT INTO `answer` VALUES (10, 9, 1, 'B.31|');
INSERT INTO `answer` VALUES (11, 9, 1, 'C.70cm|');
INSERT INTO `answer` VALUES (12, 9, 1, 'E.40|');
INSERT INTO `answer` VALUES (13, 9, 1, 'C.70cm|');
INSERT INTO `answer` VALUES (14, 9, 1, 'C.36|');
INSERT INTO `answer` VALUES (15, 9, 1, 'A.30cm|');
INSERT INTO `answer` VALUES (16, 9, 1, 'C.36|');
INSERT INTO `answer` VALUES (17, 9, 1, 'A.30cm|');
INSERT INTO `answer` VALUES (18, 9, 1, 'D.38|');
INSERT INTO `answer` VALUES (19, 9, 1, 'A.30cm|');
INSERT INTO `answer` VALUES (20, 9, 1, 'C.36|');
INSERT INTO `answer` VALUES (21, -1, 1, 'A.30cm|');
INSERT INTO `answer` VALUES (22, -1, 1, 'B.31|');
INSERT INTO `answer` VALUES (23, -1, 1, 'A.30cm|');
INSERT INTO `answer` VALUES (24, -1, 1, 'A.30|B.31|');
INSERT INTO `answer` VALUES (25, -1, 1, 'A.30cm|');
INSERT INTO `answer` VALUES (26, -1, 1, 'D.80cm|');
INSERT INTO `answer` VALUES (27, -1, 1, 'C.36|');
INSERT INTO `answer` VALUES (28, -1, 1, 'C.70cm|');
INSERT INTO `answer` VALUES (29, -1, 1, 'B.31|');
INSERT INTO `answer` VALUES (30, -1, 1, 'B.60cm|');
INSERT INTO `answer` VALUES (31, -1, 1, 'C.36|');
INSERT INTO `answer` VALUES (32, -1, 1, 'B.60cm|');
INSERT INTO `answer` VALUES (33, -1, 1, 'C.36|');
INSERT INTO `answer` VALUES (34, -1, 1, 'B.60cm|');
INSERT INTO `answer` VALUES (35, -1, 1, 'C.36|');
INSERT INTO `answer` VALUES (36, -1, 1, 'B.60cm|');
INSERT INTO `answer` VALUES (37, -1, 1, 'C.36|');
INSERT INTO `answer` VALUES (38, -1, 1, 'B.60cm|');
INSERT INTO `answer` VALUES (39, -1, 1, 'B.31|C.36|D.38|');
INSERT INTO `answer` VALUES (40, 9, 1, 'B.60cm|');
INSERT INTO `answer` VALUES (41, 9, 1, 'C.36|D.38|');
INSERT INTO `answer` VALUES (42, 9, 1, 'A.30cm|');
INSERT INTO `answer` VALUES (43, 9, 1, 'B.31|C.36|');
INSERT INTO `answer` VALUES (44, 9, 1, 'B.60cm|');
INSERT INTO `answer` VALUES (45, 9, 1, 'C.36|');
INSERT INTO `answer` VALUES (46, 9, 1, 'B.60cm|');
INSERT INTO `answer` VALUES (47, 9, 1, 'B.60cm|');
INSERT INTO `answer` VALUES (48, 9, 1, 'C.36|');
INSERT INTO `answer` VALUES (49, -1, 1, 'D.80cm|');
INSERT INTO `answer` VALUES (50, -1, 1, 'C.36|');
INSERT INTO `answer` VALUES (51, -1, 2, 'A.正确|');
INSERT INTO `answer` VALUES (52, -1, 2, 'B.50℃|');
INSERT INTO `answer` VALUES (53, -1, 3, 'A.可以|');
INSERT INTO `answer` VALUES (54, -1, 3, 'B.简单瑜伽动作|');
INSERT INTO `answer` VALUES (55, -1, 4, 'A.不能|');
INSERT INTO `answer` VALUES (56, -1, 4, 'B.不需要|');

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_bin NULL,
  `img_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `category` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 129 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES (1, '正确的哄睡方法', '', '一：哪些方法能有效的帮助宝宝睡觉呢？1、情绪平静方法        入睡最大的奥秘在于平静！要使得宝宝平静放松下来，身体接触、吮吸、有节奏温和的晃动、声音都可行。先吸引触觉、听觉、视觉乃至嗅觉中一种或几种感觉，平静是一种状态并非完全不哭泣才算平静，平静时能感受到情绪的张力正在逐渐的减小，逐渐可控。2、睡眠仪式    如果你把宝宝丢在床上他瞬间就睡着可能是已经累过头崩溃式入睡了。睡眠仪式也应运而生，利用一系列稳定的、有先后顺序能够舒缓情绪事情，来帮助情绪、状态平稳过渡也为了帮助孩子意识到：“嗨，睡眠时间到了。”比如，洗澡、穿睡衣、喝奶、刷牙、讲故事、抚触、听睡眠曲之类其实都算某种意义上的睡眠仪式。3、舒服的睡眠环境     房间内光线要适度，不可太亮，以免刺激宝宝的眼睛。宝宝喜欢睡在比较暗的环境中，光线要柔和点。抱着宝宝哄他睡觉时，要离宝宝睡觉的小床尽量靠近一点。', 'http://localhost:8088/picture/yinger2.jpg', '大师傅但是');
INSERT INTO `article` VALUES (2, '如何给婴儿洗澡 ', '', '给宝宝洗澡之前，要做如下准备：\r\n\r\n一、室温，要保持合适的室温，最好在25℃以上，要关闭门窗，防止有风进来造成宝宝受凉。\r\n\r\n二、水温，宝宝洗澡水的水温，一般是38-40℃，不能过凉或者是过热。要准备好备用的水，备用水最好是温水，不能是开水，在孩子洗澡的时候可以随时加温水。\r\n\r\n三、先洗头部，清洗头部要把孩子抱起，头朝上，这样有助于孩子清洗头部，防止水进耳朵。要把耳朵用手护住，然后擦干头部，晾干以后再洗躯干部，重点部位要多洗，如会阴、阴囊、肛门、腋下等部位，洗澡时间控制在五分钟之内。\r\n\r\n四、洗澡以后尽快擦干身体，用干的毛巾包裹，然后涂抚触油或润肤霜。越是四肢的部分越要多涂，尤其是关节的部位，防止孩子皮肤干燥，然后给宝宝适当做抚触。\r\n\r\n六、给宝宝做抚触以后要穿衣服，穿衣服要宽松合适，纯棉的衣服有助于宝宝护理。\r\n\r\n给宝宝洗澡之前，要做如下准备：一、室温，要保持合适的室温，最好在25℃以上，要关闭门窗，防止有风进来造成宝宝受凉。二、水温，宝宝洗澡水的水温，一般是38-40℃，不能过凉或者是过热。要准备好备用的水，备用水最好是温水，不能是开水，在孩子洗澡的时候可以随时加温水。三、先洗头部，清洗头部要把孩子抱起，头朝上，这样有助于孩子清洗头部，防止水进耳朵。要把耳朵用手护住，然后擦干头部，晾干以后再洗躯干部，重点部位要多洗，如会阴、阴囊、肛门、腋下等部位，洗澡时间控制在五分钟之内。四、洗澡以后尽快擦干身体，用干的毛巾包裹，然后涂抚触油或润肤霜。越是四肢的部分越要多涂，尤其是关节的部位，防止孩子皮肤干燥，然后给宝宝适当做抚触。六、给宝宝做抚触以后要穿衣服，穿衣服要宽松合适，纯棉的衣服有助于宝宝护理。七、给宝宝洗澡之前要准备好洗漱用具、要穿的衣服、大毛巾等，能够使洗澡顺利进行', 'http://localhost:8088/picture/yinger3.jpg', 'sdfds');
INSERT INTO `article` VALUES (3, '正确冲奶粉的方法', '', ' 正确的奶粉冲调步骤如下：\r\n\r\n一、首先先加水并调整好水温：40—60℃。过热可以放凉开水，过凉可以兑热水。冲调奶粉不能用滚开的水，这样会破坏奶粉中的营养物质。\r\n\r\n二、将定量的温开水倒入奶瓶内，再按照宝宝需要的量和奶瓶上的刻度调整水量。\r\n\r\n三、然后再加入适当比例的奶粉。过浓过稀都不符合宝宝的需要，后加奶粉比较好控制奶粉的量，冲出的奶粉浓度准确。\r\n\r\n 正确的奶粉冲调步骤如下：\r\n\r\n一、首先先加水并调整好水温：40—60℃。过热可以放凉开水，过凉可以兑热水。冲调奶粉不能用滚开的水，这样会破坏奶粉中的营养物质。\r\n\r\n二、将定量的温开水倒入奶瓶内，再按照宝宝需要的量和奶瓶上的刻度调整水量。\r\n\r\n 一、首先先加水并调整好水温：40—60℃。过热可以放凉开水，过凉可以兑热水。冲调奶粉不能用滚开的水，这样会破坏奶粉中的营养物质。\r\n\r\n一、正确的奶粉冲调步骤如下：首先先加水并调整好水温：40—60℃。过热可以放凉开水，过凉可以兑热水。冲调奶粉不能用滚开的水，这样会破坏奶粉中的营养物质。二、将定量的温开水倒入奶瓶内，再按照宝宝需要的量和奶瓶上的刻度调整水量。 三、然后再加入适当比例的奶粉。过浓过稀都不符合宝宝的需要，后加奶粉比较好控制奶粉的量，冲出的奶粉浓度准确。 这样冲调比较容易控制水温和水量。如果先加奶粉，水温不合适，水量没掌握好，都可能浪费时间和奶粉。 ', 'http://localhost:8088/picture/yinger4.jpg', '风格豆腐干发');

-- ----------------------------
-- Table structure for audio
-- ----------------------------
DROP TABLE IF EXISTS `audio`;
CREATE TABLE `audio`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `audioURL` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `category` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `cover_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1236822 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of audio
-- ----------------------------
INSERT INTO `audio` VALUES (1, '阴天-莫文蔚', 'http://localhost:8088/audio/yintian.mp3', '', 'http://localhost:8088/picture/mowenwei.jpg');
INSERT INTO `audio` VALUES (2, '兄弟抱一下_庞龙', 'http://localhost:8088/audio/xiongdibaoyixia.mp3', '', 'http://localhost:8088/picture/panglong.jpg');
INSERT INTO `audio` VALUES (3, '白若溪 - 无处安放', 'http://localhost:8088/audio/白若溪 - 无处安放.mp3', '', 'http://localhost:8088/picture/bairuoxi.jpg');
INSERT INTO `audio` VALUES (4, '薛之谦 - 绅士', 'http://localhost:8088/audio/薛之谦 - 绅士.mp3', '', 'http://localhost:8088/picture/xuezhiqian.jpg');
INSERT INTO `audio` VALUES (5, '阴天-莫文蔚', 'http://localhost:8088/audio/yintian.mp3', '', 'http://localhost:8088/picture/mowenwei.jpg');
INSERT INTO `audio` VALUES (6, '兄弟抱一下_庞龙', 'http://localhost:8088/audio/xiongdibaoyixia.mp3', '', 'http://localhost:8088/picture/panglong.jpg');
INSERT INTO `audio` VALUES (7, '白若溪 - 无处安放', 'http://localhost:8088/audio/白若溪 - 无处安放.mp3', '', 'http://localhost:8088/picture/bairuoxi.jpg');
INSERT INTO `audio` VALUES (8, '薛之谦 - 绅士', 'http://localhost:8088/audio/薛之谦 - 绅士.mp3', '', 'http://localhost:8088/picture/xuezhiqian.jpg');

-- ----------------------------
-- Table structure for auto_answer_template
-- ----------------------------
DROP TABLE IF EXISTS `auto_answer_template`;
CREATE TABLE `auto_answer_template`  (
  `consult_id` int(11) NOT NULL AUTO_INCREMENT,
  `question_key` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '问题',
  `answer_template` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '答案',
  PRIMARY KEY (`consult_id`) USING BTREE,
  UNIQUE INDEX `question_key_UNIQUE`(`question_key`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户提问小程序客服答案模板' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auto_answer_template
-- ----------------------------

-- ----------------------------
-- Table structure for collection
-- ----------------------------
DROP TABLE IF EXISTS `collection`;
CREATE TABLE `collection`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `coll_type` int(11) NOT NULL COMMENT '收藏的类型 1-文章 2-音频 3-视频',
  `coll_id` int(11) NOT NULL COMMENT '收藏id',
  PRIMARY KEY (`id`) USING BTREE,
  CONSTRAINT `id` FOREIGN KEY (`id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of collection
-- ----------------------------
INSERT INTO `collection` VALUES (2, 456, 1, 1);
INSERT INTO `collection` VALUES (3, 456, 1, 1);
INSERT INTO `collection` VALUES (4, 456, 1, 1);
INSERT INTO `collection` VALUES (5, 456, 1, 2);

-- ----------------------------
-- Table structure for consult_order
-- ----------------------------
DROP TABLE IF EXISTS `consult_order`;
CREATE TABLE `consult_order`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `doctor_id` int(11) NOT NULL COMMENT '订单所属医生id',
  `user_id` int(11) NOT NULL COMMENT '订单所属用户id',
  `create_time` timestamp(0) NOT NULL,
  `lasting_time` int(11) NOT NULL COMMENT '订单有效期（经过多久后订单完成）',
  `contact` varchar(5) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '联系人姓名',
  `contact_phone` varchar(15) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '联系人电话',
  `symptom_description` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '订单所属用户病情描述',
  `consult_cost` int(11) NULL DEFAULT NULL,
  `status` int(11) NULL DEFAULT NULL,
  `oid` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `user_open_id` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `doctor_open_id` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `img_urls` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id_id_idx`(`user_id`) USING BTREE,
  INDEX `doctor_id_idx`(`doctor_id`) USING BTREE,
  CONSTRAINT `doctor_id` FOREIGN KEY (`doctor_id`) REFERENCES `doctor` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `user_id_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 87 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '咨询订单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of consult_order
-- ----------------------------
INSERT INTO `consult_order` VALUES (78, 10, 9, '2022-04-07 02:51:58', 86400000, '到饭店', '19957484574', '地方都是', 5, 1, '697d74074c3641f0be633b47c1a33b83', '', 'o4YjA4uD9PLpxPAIpuy4VR4S_HBI', '');
INSERT INTO `consult_order` VALUES (79, 10, 10, '2022-04-07 03:59:02', 86400000, '333', '19957487544', '地方都是', 5, 1, '15ed2a78b44643979b0c627fbdc8c7c6', '', 'o4YjA4uD9PLpxPAIpuy4VR4S_HBI', '');
INSERT INTO `consult_order` VALUES (80, 10, 9, '2022-04-07 06:57:19', 86400000, '324', '19924577488', 'dsfd', 5, 1, '094536f0cd844c9786cba1fa8dc7620f', '', 'o4YjA4uD9PLpxPAIpuy4VR4S_HBI', '');
INSERT INTO `consult_order` VALUES (81, 10, 9, '2022-04-07 07:10:39', 86400000, '444', '19925457845', '的方式', 5, 1, '22fa5578c24e443e922a4b1a4266df5a', '', 'o4YjA4uD9PLpxPAIpuy4VR4S_HBI', '');
INSERT INTO `consult_order` VALUES (82, 10, 9, '2022-04-07 12:18:51', 86400000, '34', '19925545748', 'dfdsfd', 5, 1, '80345a1e409e4ea98959cf61f20fc67f', '', 'o4YjA4uD9PLpxPAIpuy4VR4S_HBI', '');
INSERT INTO `consult_order` VALUES (83, 10, 9, '2022-04-07 12:20:56', 86400000, '343', '16657485424', '到饭店', 5, 1, '8919c07dcd4c42698e1c6a8d186432d4', '', 'o4YjA4uD9PLpxPAIpuy4VR4S_HBI', '');
INSERT INTO `consult_order` VALUES (84, 10, 9, '2022-04-09 02:40:53', 86400000, '111', '18824577485', '似懂非懂', 5, 1, '097ecf752da745f5b8d46941fdbc7f05', '', 'o4YjA4uD9PLpxPAIpuy4VR4S_HBI', '');
INSERT INTO `consult_order` VALUES (85, 10, 9, '2022-04-11 06:05:13', 86400000, '111', '19927577877', 'dffdsfds', 5, 1, 'febc941e1417413386aac59eb9b46cc8', '', 'o4YjA4uD9PLpxPAIpuy4VR4S_HBI', '');
INSERT INTO `consult_order` VALUES (86, 10, 9, '2022-04-11 06:18:22', 86400000, '黄女士', '17727548456', '孩子中午肚子疼，如何快速处理？', 5, 1, 'de6228348d484459914883f68e288e9e', '', 'o4YjA4uD9PLpxPAIpuy4VR4S_HBI', '');
INSERT INTO `consult_order` VALUES (87, 10, 9, '2022-04-13 10:45:02', 86400000, '11', '19952454784', 'sdsf', 5, NULL, 'f514e135268445e2a76749685820247c', '', 'o4YjA4uD9PLpxPAIpuy4VR4S_HBI', '');

-- ----------------------------
-- Table structure for doctor
-- ----------------------------
DROP TABLE IF EXISTS `doctor`;
CREATE TABLE `doctor`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '用户名',
  `user_password` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '用户密码',
  `token` char(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `name` varchar(5) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '医生真实姓名',
  `voice_cost` int(11) NULL DEFAULT NULL,
  `license_number` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '执业证号',
  `expert_in` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `video_cost` int(11) NULL DEFAULT NULL,
  `img_url` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `open_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `imagetext_cost` int(11) NULL DEFAULT NULL,
  `uuid` char(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '用户唯一标识符',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user_name_UNIQUE`(`user_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '医生信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of doctor
-- ----------------------------
INSERT INTO `doctor` VALUES (10, '张三', '38523981dac3034f43cacb0d3b9ac911', 'dfec8ebbed8442edac39f27e3cb22076', '张三', NULL, '111111', '内科 神经科', NULL, 'http://localhost:8088/picture/yisheng1.jpg', 'o4YjA4uD9PLpxPAIpuy4VR4S_HBI', NULL, 'c3e286be6b894824b2723ad5d0ce9a60');
INSERT INTO `doctor` VALUES (11, '李四', '38523981dac3034f43cacb0d3b9ac911', 'e4a0742b24564ef599bb548f1b48b78b', '李四', NULL, '222222', '喉咙科  感冒', NULL, 'http://localhost:8088/picture/yisheng5.jpg', 'o4YjA4uD9PLpxPAIpuy4VR4S_HBI', NULL, 'd894d3f9bace433a88796e94e630c54a');
INSERT INTO `doctor` VALUES (12, '赵五', 'af005225c7e0b192958c1e6b32297c1d', 'b6013e9b78dc401b953632fdd22c5dcf', '赵五', NULL, '333333', '骨伤科', NULL, 'http://localhost:8088/picture/yisheng6.jpg', 'o4YjA4uD9PLpxPAIpuy4VR4S_HBI', NULL, 'efb2a34b3f6448299d1cff8c589fd101');
INSERT INTO `doctor` VALUES (13, '陈六', '38523981dac3034f43cacb0d3b9ac911', '1cc0d1f2f7ff4e6caa42591109b01451', '陈六', NULL, '444444', '脑科 耳鼻科', NULL, 'http://localhost:8088/picture/yisheng7.jpg', 'o4YjA4uD9PLpxPAIpuy4VR4S_HBI', NULL, '4a47e71ec9544bd8985cdad73ab667e5');

-- ----------------------------
-- Table structure for question
-- ----------------------------
DROP TABLE IF EXISTS `question`;
CREATE TABLE `question`  (
  `q_id` int(11) NOT NULL,
  `t_id` int(11) NOT NULL COMMENT '问卷id',
  `q_type` int(11) NOT NULL COMMENT '题目类型 1单选题 0多选题',
  `q_content` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '问卷题目内容',
  `q_opstions` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '问卷选项，选项之间用 ‘|’ 隔开',
  `q_answer` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '问卷答案',
  PRIMARY KEY (`q_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '问卷具体题目' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of question
-- ----------------------------
INSERT INTO `question` VALUES (1, 1, 1, '洗澡水水位应该多高？', 'A.30cm|B.60cm|C.70cm|D.80cm|E.都行', 'A');
INSERT INTO `question` VALUES (2, 1, 0, '下列洗澡水的温度哪些是合适的？', 'A.30|B.31|C.36|D.38|E.40', 'ABC');
INSERT INTO `question` VALUES (3, 1, 1, '幼儿在洗澡时不需要有人陪伴在旁边？', 'A.正确|B.错误', 'A');
INSERT INTO `question` VALUES (4, 2, 1, '冲奶粉不需要用热水吗？', 'A.正确|B.错误', 'B');
INSERT INTO `question` VALUES (5, 2, 1, '冲奶粉的合理温度？', 'A.36℃|B.50℃|C.45℃', 'A');
INSERT INTO `question` VALUES (6, 2, 1, '婴儿喝奶粉需要保持什么姿势？', 'A.躺着|B.抱着|C.坐着', 'B');
INSERT INTO `question` VALUES (7, 3, 1, '怀孕期间可以做跑步、打羽毛球等剧烈运动吗？', 'A.可以|B.不可以', 'B');
INSERT INTO `question` VALUES (8, 3, 0, '怀孕期间可以做一下那些运动？', 'A.慢走|B.简单瑜伽动作|C.哑铃|D.平板支撑', 'AB');
INSERT INTO `question` VALUES (9, 3, 1, '怀孕期间运动后应该及时摄入葡萄糖、维生素等物质？', 'A.正确|B.不正确', 'A');
INSERT INTO `question` VALUES (10, 4, 1, '抱着婴儿期间可以大力晃动吗?', 'A.不能|B.能', 'A');
INSERT INTO `question` VALUES (11, 4, 1, '抱着婴儿的需要双手环抱吗?', 'A.需要|B.不需要', 'A');
INSERT INTO `question` VALUES (12, 4, 0, '当婴儿不慎滑落，需要抓住哪些部位防止婴儿受伤？', 'A.手|B.脚|C.头|D.腰', 'ABC');

-- ----------------------------
-- Table structure for score
-- ----------------------------
DROP TABLE IF EXISTS `score`;
CREATE TABLE `score`  (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `score` int(10) NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of score
-- ----------------------------
INSERT INTO `score` VALUES (-1, 0);
INSERT INTO `score` VALUES (2, 0);
INSERT INTO `score` VALUES (9, 10);

-- ----------------------------
-- Table structure for search_content
-- ----------------------------
DROP TABLE IF EXISTS `search_content`;
CREATE TABLE `search_content`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of search_content
-- ----------------------------

-- ----------------------------
-- Table structure for test
-- ----------------------------
DROP TABLE IF EXISTS `test`;
CREATE TABLE `test`  (
  `id` int(11) NOT NULL,
  `t_title` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `img_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `content` varchar(2048) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of test
-- ----------------------------
INSERT INTO `test` VALUES (1, '婴儿洗澡如何操作', 'http://localhost:8088/picture/yinger7.jpg', '给婴儿洗澡主要注意的方方面面');
INSERT INTO `test` VALUES (2, '冲奶粉的正确步骤', 'http://localhost:8088/picture/yinger10.jpg', '冲奶粉需要注意的细节');
INSERT INTO `test` VALUES (3, '怀孕期间运动', 'http://localhost:8088/picture/yinger11.jpg', '怀孕期间如何健康运动');
INSERT INTO `test` VALUES (4, '正确抱婴儿的姿势', 'http://localhost:8088/picture/yinger12.jpg', '纠正抱婴儿的错误方式');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `age` int(11) NULL DEFAULT NULL,
  `credit_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `pregnant_type` int(11) NOT NULL,
  `pregnant_week` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `job` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `confinement_date` date NULL DEFAULT NULL,
  `confinement_week` int(11) NULL DEFAULT NULL,
  `confinement_type` int(11) NULL DEFAULT NULL,
  `user_name` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `user_password` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `user_token` char(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '用户登录token',
  `open_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `img_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '用户头像',
  `uuid` char(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '用户唯一唯一标识符',
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `credit_id_UNIQUE`(`credit_id`) USING BTREE,
  UNIQUE INDEX `user_name_UNIQUE`(`user_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 45, '440506199903220147', 1, '15', '', NULL, NULL, NULL, 'breast', '38523981dac3034f43cacb0d3b9ac911', '6ec9955349bb46a386226d466726e392', 'oby6g4gzlRYKAZKmINMKVC-Z12hY', 'http://llllllllr.top/cover4.jpg2771', '6ec9955349bb46a386226d466726e392');
INSERT INTO `user` VALUES (2, 25, '440506199905221765', 1, '16', '', NULL, NULL, NULL, 'breast1', '38523981dac3034f43cacb0d3b9ac911', 'fddf0532a2864bf78a807eb90a2e27e9', '', 'http://llllllllr.top/cover4.jpg2771', 'fddf0532a2864bf78a807eb90a2e27e9');
INSERT INTO `user` VALUES (3, 20, '440582199803014890', 1, '12', '???', NULL, NULL, NULL, '????', 'e23b3c41c2ac6502b56d98532b7d90a8', '0b11f545c82549f3968c220466a89754', '', 'http://llllllllr.top/cover4.jpg2771', '0b11f545c82549f3968c220466a89754');
INSERT INTO `user` VALUES (4, 22, '450421199804283017', 11, NULL, '??', NULL, 10, 11, '???', 'e23b3c41c2ac6502b56d98532b7d90a8', 'b2a5b7bdc4cf4722bc67f0175cbb6f57', 'o4YjA4s0Cjm3d7iLnxTj4v8fAIg0', 'http://llllllllr.top/cover4.jpg2771', 'b2a5b7bdc4cf4722bc67f0175cbb6f57');
INSERT INTO `user` VALUES (5, 20, '450421199804283011', 1, '1', '??', NULL, NULL, NULL, 'yhcq', 'e23b3c41c2ac6502b56d98532b7d90a8', '807212797cd14f09b021473df418e55b', 'o4YjA4s0Cjm3d7iLnxTj4v8fAIg0', 'http://llllllllr.top/cover4.jpg2771', '807212797cd14f09b021473df418e55b');
INSERT INTO `user` VALUES (6, 54, '440506199901220547', 1, '15', 'dsf', NULL, NULL, NULL, 'test', '38523981dac3034f43cacb0d3b9ac911', '874ff39cd0514907b581d638e8aa7191', 'o4YjA4s0Cjm3d7iLnxTj4v8fAIg0', 'http://llllllllr.top/cover4.jpg2771', '874ff39cd0514907b581d638e8aa7191');
INSERT INTO `user` VALUES (7, 56, '440506199904220718', 1, '12', '', NULL, NULL, NULL, 'breast2', '38523981dac3034f43cacb0d3b9ac911', 'bd4ee4735806463089ff4e10b3b2791c', 'o4YjA4rfdU1AFKyhd8G4nDPh4WtQ', 'http://llllllllr.top/cover4.jpg2771', '19449793bbf4496292f03b3e341ce60b');
INSERT INTO `user` VALUES (8, 45, '440506199503125478', 1, '22', '', NULL, NULL, NULL, 'test111', '5990ba09b92e2fbc3f13b7949b6712bd', '24632763edff49189f8176343d662f0f', 'o4YjA4uD9PLpxPAIpuy4VR4S_HBI', NULL, '9d9848a01f6649d78cd2bceaba13c7cd');
INSERT INTO `user` VALUES (9, 32, '440516199903110748', 1, '11', '', NULL, NULL, NULL, '111111', '38523981dac3034f43cacb0d3b9ac911', 'f7ec58ca812f40ada9f1728f1ad77f6f', '', 'https://pics7.baidu.com/feed/a8773912b31bb051fb37de05c78e64b24bede083.jpeg?http://localhost:8088/picture/1.jpg', '103ee258883f4e3d9e85bd0874c8e671');
INSERT INTO `user` VALUES (10, 23, '440526199902110417', 1, '11', '', NULL, NULL, NULL, '222222', 'dff4ee2c48039e80a3789e2e735f4741', 'b4a57c5e83c04f3b8f91af6f0d3f4501', '', 'https://pics7.baidu.com/feed/a8773912b31bb051fb37de05c78e64b24bede083.jpeg?token=f02d22e51399a01c6c239e6247cec44f', '22a26a28b7ac4586940f648e732d38d8');

-- ----------------------------
-- Table structure for vedio
-- ----------------------------
DROP TABLE IF EXISTS `vedio`;
CREATE TABLE `vedio`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `vedioURL` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `cover_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `category` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of vedio
-- ----------------------------
INSERT INTO `vedio` VALUES (1, '有趣的婴幼儿动画片', 'http://localhost:8088/video/quweidonghua.mp4', 'http://localhost:8088/picture/quweidonghua.jpg', NULL, '加强幼儿认知能力的动画片！！！！');
INSERT INTO `vedio` VALUES (2, '《加油小兔子》书籍推荐', 'http://localhost:8088/video/shujituijian.mp4', 'http://localhost:8088/picture/shujituijian.jpg', NULL, '婴幼儿数据推荐!!');
INSERT INTO `vedio` VALUES (14, '四大名著连环画', 'http://localhost:8088/video/sidamingzhu.mp4', 'http://localhost:8088/picture/sidamingzhu.jpg', NULL, '有益于婴幼儿学习传统文化的四大名著连环画！！生动有趣!!!');

-- ----------------------------
-- Table structure for wechat_message_item
-- ----------------------------
DROP TABLE IF EXISTS `wechat_message_item`;
CREATE TABLE `wechat_message_item`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `from_uuid` char(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '\'发送方\'',
  `to_uuid` char(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '\'接收方\'',
  `message_type` int(1) NOT NULL COMMENT '消息类型 0表示文本 1表示图片 2表示视频 3表示可选择的文本',
  `message_content` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '消息类型为文本 -》 文本\n图片 视频 -》 存储路径',
  `time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '消息时间',
  `oid` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `status` int(1) NULL DEFAULT NULL COMMENT '1已读0未读',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 186 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '聊天信息条目' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wechat_message_item
-- ----------------------------
INSERT INTO `wechat_message_item` VALUES (185, '103ee258883f4e3d9e85bd0874c8e671', 'c3e286be6b894824b2723ad5d0ce9a60', 0, '医生请问孩子肚子疼怎么解决', '2022-04-13 10:45:58', 'f514e135268445e2a76749685820247c', 1);
INSERT INTO `wechat_message_item` VALUES (186, 'c3e286be6b894824b2723ad5d0ce9a60', '103ee258883f4e3d9e85bd0874c8e671', 0, '吃了什么不健康的东西吗', '2022-04-13 10:46:43', 'f514e135268445e2a76749685820247c', 1);

SET FOREIGN_KEY_CHECKS = 1;
