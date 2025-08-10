/*
 Navicat Premium Dump SQL

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80041 (8.0.41)
 Source Host           : localhost:3306
 Source Schema         : xm-pet-mall

 Target Server Type    : MySQL
 Target Server Version : 80041 (8.0.41)
 File Encoding         : 65001

 Date: 08/08/2025 20:31:24
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '姓名',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '电话',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '管理员信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (2, 'A001', '11', 'http://localhost:8080/files/download/1754653266889_屏幕截图 2025-08-08 194057.png', '喜羊羊', '18899998888', 'xiyangyang@xm.com', 'ADM');
INSERT INTO `admin` VALUES (5, 'A002', '11', NULL, '张三', '18899992222', 'zhangsan@xm.com', 'ADM');
INSERT INTO `admin` VALUES (6, 'A003', '11', NULL, '李四', '18899993333', 'lisi@xm.com', 'ADM');

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '商品名称',
  `shop_id` int NULL DEFAULT NULL COMMENT '商品价格',
  `type_id` int NULL DEFAULT NULL COMMENT '商品图片',
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `price` decimal(10, 2) NULL DEFAULT NULL,
  `introduce` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '商品信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES (5, '鱼粮金鱼饲料观赏鱼锦鲤鱼食增色大中小颗粒不浑水饵料粮上浮型', 14, 16, 'http://localhost:8080/files/download/1754653653017_屏幕截图 2025-08-08 194443.png', 6.66, '适用对象：主要适用于金鱼和锦鲤，也可用于其他一些观赏鱼，如血鹦鹉鱼、罗汉鱼等，能满足不同品种观赏鱼的摄食需求。\n颗粒规格：有大、中、小三种颗粒规格。小颗粒一般在 0.5-1mm 左右，适合幼鱼或小型观赏鱼，如小型金鱼苗等；中颗粒通常为 2-3mm，适合中等体型的观赏鱼，大多数成鱼阶段的金鱼和锦鲤都适用；大颗粒大概在 3-8mm，主要针对体型较大的锦鲤等观赏鱼。', '上架');
INSERT INTO `goods` VALUES (6, '鱼食金鱼锦鲤鱼饲料小颗粒鱼粮观赏鱼家用小金鱼专用鱼料小型鲤鱼', 14, 16, 'http://localhost:8080/files/download/1754653914798_屏幕截图 2025-08-08 195151.png', 9.99, '适用对象：主要适用于小金鱼、小型鲤鱼等小型观赏鱼，也可用于其他体型相近的观赏鱼，如斗鱼、灯科鱼、虎皮鱼等。\n颗粒特点：颗粒较小，一般在 0.5-2mm 左右，适合小型鱼的嘴巴大小，方便它们吞咽和消化吸收。这种小颗粒设计还能让饲料在水中更稳定，不易破碎溃散，减少水质污染。', '上架');
INSERT INTO `goods` VALUES (7, '佩尼森地图鱼专用饲料观赏鱼饲料大颗粒上浮热带鱼鱼食小颗粒鱼粮', 14, 16, 'http://localhost:8080/files/download/1754654026626_屏幕截图 2025-08-08 195325.png', 16.66, '颗粒特点：采用上浮性颗粒设计，方便地图鱼等热带鱼从水面摄取食物，符合其习性，也便于主人观察进食情况和控制投喂量。大颗粒适合成年地图鱼等体型较大的热带鱼，小颗粒则可满足幼鱼或嘴巴较小的鱼类摄食需求。\n营养成分：主要成分包括鱼粉、虾粉、昆虫粉等，蛋白质含量丰富，粗蛋白含量＞50%，还含有粗脂肪、粗纤维、粗灰粉、赖氨酸、钙、磷等成分，营养均衡，能满足地图鱼生长发育的营养需求。', '上架');
INSERT INTO `goods` VALUES (8, '孔雀鱼上浮饲料小鱼鱼食小颗粒微小型鱼粮斗鱼灯科鱼观赏热带鱼粮', 14, 16, 'http://localhost:8080/files/download/1754654130377_屏幕截图 2025-08-08 195507.png', 19.99, '颗粒特点：颗粒通常非常小，一般在 1 毫米左右甚至更小，符合小型鱼嘴巴小巧的特征，方便它们轻松吞食，不会出现吞咽困难的情况，大大提高了适口性。\n上浮型设计：采用上浮型设计，饲料投入水中后会漂浮在水面。这不仅方便主人观察鱼儿的进食情况，及时掌握鱼儿的健康状态和食欲，还能让习惯在水的上层觅食的孔雀鱼、斗鱼等轻松获取食物，同时避免饲料沉底堆积，减少水质污染。', '上架');
INSERT INTO `goods` VALUES (9, '卫仕五拼冻干狗粮中小型犬狗粮泰迪幼犬狗粮成犬粮比熊柯基官方', 19, 14, 'http://localhost:8080/files/download/1754654247305_屏幕截图 2025-08-08 195706.png', 89.67, '配方与营养：采用五拼组合，包含鹿肉、三文鱼、鸡肉、鸡肝、鸡心等多种冻干成分，占比达 9%。鹿肉可提供高质量蛋白质和铁元素，三文鱼富含不饱和脂肪酸，有助于美毛。还添加了胡萝卜粉、南瓜粉、海带粉等蔬菜和水果，富含膳食纤维和维生素，其中南瓜粉利于心血管健康，海带粉可美毛。', '上架');
INSERT INTO `goods` VALUES (10, '奥丁鸭肉梨冻干狗粮成犬幼犬泰迪柯基比熊金毛小型犬专用小狗犬粮', 19, 14, 'http://localhost:8080/files/download/1754654392759_屏幕截图 2025-08-08 195940.png', 39.99, '奥丁鸭肉梨冻干狗粮，狗狗的健康美味之选\n还在为你家 “毛孩子” 选粮发愁？奥丁鸭肉梨冻干狗粮了解一下！无论是活泼好动的幼犬，还是沉稳优雅的成犬，这款狗粮都能轻松拿捏，尤其适合泰迪、柯基、比熊、金毛等小型犬，绝对是铲屎官们的福音！', '上架');
INSERT INTO `goods` VALUES (11, '冻干猫粮10斤装成猫5kg幼猫生骨肉增肥营养发腮全价20大袋通用8斤', 19, 13, 'http://localhost:8080/files/download/1754654482415_屏幕截图 2025-08-08 200100.png', 39.99, '冻干猫粮：全阶段猫咪的营养优选\n这款冻干猫粮有 10 斤（5kg）、8 斤、20 斤等多种规格，适合成猫、幼猫等全阶段猫咪食用，主打增肥、营养、发腮，是性价比颇高的选择。', '上架');
INSERT INTO `goods` VALUES (12, '【美味适口 靓毛发】全价猫粮肉松夹心鲜肉益生菌鱼油成猫幼猫粮', 19, 13, 'http://localhost:8080/files/download/1754654599323_屏幕截图 2025-08-08 200248.png', 39.99, '全价猫粮（肉松夹心款）：美味与养护兼具的猫咪优选\n这款全价猫粮主打 “美味适口、靓毛发”，专为成猫和幼猫设计，融合了肉松夹心、鲜肉成分，还添加益生菌和鱼油，兼顾口感与营养，是猫咪日常饮食的理想选择。', '上架');
INSERT INTO `goods` VALUES (13, '贵州生源妙歌画眉鸟食专用饲料正宗斗唱鸟粮观赏鸟专用鸟食含虫干', 20, 15, 'http://localhost:8080/files/download/1754654710817_屏幕截图 2025-08-08 200454.png', 9.99, '贵州生源妙歌画眉鸟食，专为斗唱鸟打造的极致美味\n在画眉鸟的饲养中，一款优质的饲料对鸟儿的健康与状态起着决定性作用。贵州生源妙歌画眉鸟食专用饲料，正是爱鸟人士不可多得的绝佳选择，尤其适合斗唱画眉，凭借其独特配方和高品质原料，深受广大养鸟爱好者青睐。', '上架');
INSERT INTO `goods` VALUES (14, '开元八哥幼鸟粮专用鸟食八哥雏鸟料林八黑八换羽虫干饲料营养鸟食', 20, 15, 'http://localhost:8080/files/download/1754654768264_屏幕截图 2025-08-08 200553.png', 28.99, '开元八哥幼鸟粮，开启爱鸟健康成长之旅\n对于饲养八哥鸟的朋友来说，一款优质的鸟粮至关重要，它关乎八哥的健康、活力与成长发育。开元八哥幼鸟粮，作为一款专为八哥雏鸟精心打造的饲料，凭借其卓越品质与独特配方，在鸟友圈中广受赞誉，无论是林八还是黑八，都能在这款鸟粮中找到成长所需的全部营养。', '上架');
INSERT INTO `goods` VALUES (15, '蜜袋鼯粮食幼蜜粮主粮蜜袋鼬主食营养冲泡粮蜜粮食物幼崽用品奶粉', 20, 22, 'http://localhost:8080/files/download/1754654875589_屏幕截图 2025-08-08 200714.png', 26.59, '呵护蜜袋鼯成长的专属粮，你选对了吗？\n在养宠热潮中，蜜袋鼯以其软萌可爱的模样、独特的 “飞行” 技能，俘获了众多铲屎官的心。想要自家小蜜健康活泼，茁壮成长，选对主粮可是关键中的关键。今天就来给大家讲讲超棒的蜜袋鼯粮食，尤其是幼蜜粮，从冲泡粮到奶粉，全方位满足小蜜不同成长阶段的营养需求。', '上架');
INSERT INTO `goods` VALUES (16, '蜜袋鼯粮食增肥主食飞鼠固体饲料 蜜袋鼬hpw颗粒干粮小蜜专用食物', 20, 22, 'http://localhost:8080/files/download/1754654912119_屏幕截图 2025-08-08 200815.png', 36.66, '蜜袋鼯增肥神器：HPW 颗粒干粮，飞鼠的能量源泉\n养蜜袋鼯的铲屎官们，是不是总盼着自家软萌的小蜜能胖嘟嘟、圆滚滚，抱在手里手感超棒？别愁啦，这款蜜袋鼯增肥主食 —— 飞鼠固体饲料（HPW 颗粒干粮），绝对是小蜜健康增肥的 “秘密武器”，专为蜜袋鼬打造，堪称小蜜专用食物中的 “尖子生”。', '上架');

-- ----------------------------
-- Table structure for goods_type
-- ----------------------------
DROP TABLE IF EXISTS `goods_type`;
CREATE TABLE `goods_type`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '类型名称',
  PRIMARY KEY (`id` DESC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '宠物商品类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods_type
-- ----------------------------
INSERT INTO `goods_type` VALUES (22, '其他食品');
INSERT INTO `goods_type` VALUES (21, '玩具');
INSERT INTO `goods_type` VALUES (20, '药品');
INSERT INTO `goods_type` VALUES (19, '清洁用品');
INSERT INTO `goods_type` VALUES (18, '钙片');
INSERT INTO `goods_type` VALUES (17, '维生素');
INSERT INTO `goods_type` VALUES (16, '鱼食');
INSERT INTO `goods_type` VALUES (15, '鸟食');
INSERT INTO `goods_type` VALUES (14, '狗粮');
INSERT INTO `goods_type` VALUES (13, '猫粮');

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`  (
  `id` int(10) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT COMMENT '订单ID',
  `order_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '订单编号',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '商品名称',
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '总价',
  `user_id` int NULL DEFAULT NULL COMMENT '用户ID',
  `shop_id` int NULL DEFAULT NULL COMMENT '宠物店ID',
  `number` int NULL DEFAULT NULL COMMENT '数量',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 44 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES (0000000012, 'ORD-1753781406657-186', '小丑鱼', 'http://localhost:8080/files/download/1745590305057_屏幕截图 2025-04-25 221129.png', 35.00, 3, 14, 1, '已发货');
INSERT INTO `order` VALUES (0000000021, 'ORD-1753781937461-402', '智利红玫瑰蜘蛛', 'http://localhost:8080/files/download/1745667443155_屏幕截图 2025-04-26 193714.png', 49.90, 3, 14, 1, '已收货');
INSERT INTO `order` VALUES (0000000034, 'ORD-1754655125329-159', '佩尼森地图鱼专用饲料观赏鱼饲料大颗粒上浮热带鱼鱼食小颗粒鱼粮', 'http://localhost:8080/files/download/1754654026626_屏幕截图 2025-08-08 195325.png', 66.64, 3, 14, 4, '未发货');
INSERT INTO `order` VALUES (0000000041, 'ORD-1754656059603-609', '布偶猫', 'http://localhost:8080/files/download/1745667056746_屏幕截图 2025-04-26 193046.png', 999.99, 4, 19, 1, '已收货');
INSERT INTO `order` VALUES (0000000042, 'ORD-1754656086305-515', '【美味适口 靓毛发】全价猫粮肉松夹心鲜肉益生菌鱼油成猫幼猫粮', 'http://localhost:8080/files/download/1754654599323_屏幕截图 2025-08-08 200248.png', 159.96, 4, 19, 4, '已发货');
INSERT INTO `order` VALUES (0000000043, 'ORD-1754656181240-9', '三花猫', 'http://localhost:8080/files/download/1745666843651_屏幕截图 2025-04-26 192702.png', 300.00, 4, 19, 1, '未发货');

-- ----------------------------
-- Table structure for pet
-- ----------------------------
DROP TABLE IF EXISTS `pet`;
CREATE TABLE `pet`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `shop_id` int NULL DEFAULT NULL COMMENT '宠物店',
  `type_id` int NULL DEFAULT NULL COMMENT '宠物类型',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '宠物名称',
  `sex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '宠物性别',
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '宠物图片',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '宠物价格',
  `introduce` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '宠物介绍',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '宠物详情',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '宠物状态',
  `recommend` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否推荐',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '宠物信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of pet
-- ----------------------------
INSERT INTO `pet` VALUES (3, 14, 9, '小丑鱼', '无性别', 'http://localhost:8080/files/download/1745590305057_屏幕截图 2025-04-25 221129.png', 35.00, '小丑鱼，学名双锯鱼属（Amphiprion）鱼类，是热带珊瑚礁海域中一类色彩艳丽、行为独特的观赏鱼类，因与海葵的共生关系及雌雄同体的生物学特性而闻名。', '<p style=\"text-align: start;\"><strong>小丑鱼介绍</strong></p><p style=\"text-align: start;\">小丑鱼，学名双锯鱼属（<em>Amphiprion</em>）鱼类，是热带珊瑚礁海域中一类色彩艳丽、行为独特的观赏鱼类，因与海葵的共生关系及雌雄同体的生物学特性而闻名。以下是其详细介绍：</p><h3 style=\"text-align: start;\"><strong>一、形态特征</strong></h3><ul><li style=\"text-align: start;\"><strong>体型</strong>：成鱼体长5-15厘米，体型椭圆形且侧扁，头部较大，眼睛占比突出。</li><li style=\"text-align: start;\"><strong>体色</strong>：以橙色、红色为基底，体侧常有1-3条白色条纹（似京剧丑角妆容），部分种类具黑色斑点或镶边。例如：</li><li style=\"text-align: start;\"><strong>鳍部</strong>：除透明胸鳍外，背鳍、臀鳍、尾鳍多呈黑色，边缘可能带白色或黑色镶边。</li></ul><h3 style=\"text-align: start;\"><strong>二、栖息环境</strong></h3><ul><li style=\"text-align: start;\"><strong>分布</strong>：印度洋-太平洋热带海域，包括红海、大堡礁、东南亚珊瑚礁群等。</li><li style=\"text-align: start;\"><strong>栖息地</strong>：浅海珊瑚礁、岩礁或潟湖，水深1-55米，偏好水温24-27℃、盐度29‰-31‰的环境。</li><li style=\"text-align: start;\"><strong>共生关系</strong>：与海葵形成互利共生：</li></ul><h3 style=\"text-align: start;\"><strong>三、生物学特性</strong></h3><ol><li style=\"text-align: start;\"><strong>雌雄同体与性别转换</strong>：</li><li style=\"text-align: start;\"><strong>领地行为</strong>：</li><li style=\"text-align: start;\"><strong>食性</strong>：</li><li style=\"text-align: start;\"><strong>繁殖</strong>：</li></ol><h3 style=\"text-align: start;\"><strong>四、生态价值与保护现状</strong></h3><ul><li style=\"text-align: start;\"><strong>生态角色</strong>：作为珊瑚礁生态系统的重要组成部分，参与物质循环和能量流动。</li><li style=\"text-align: start;\"><strong>保护状况</strong>：</li></ul><h3 style=\"text-align: start;\"><strong>五、文化与经济意义</strong></h3><ul><li style=\"text-align: start;\"><strong>观赏价值</strong>：因鲜艳色彩和独特行为成为水族馆热门展示品种。</li><li style=\"text-align: start;\"><strong>科研价值</strong>：性别转换机制为生物学研究提供模型。</li></ul><p style=\"text-align: start;\"><strong>总结</strong>：小丑鱼以其迷人的外观、复杂的共生关系和神奇的性别转换能力，成为海洋生物多样性的标志性物种，同时也是生态保护和科学研究的重要对象。</p>', '上架', '是');
INSERT INTO `pet` VALUES (4, 19, 5, '拉布拉多', '雄性', 'http://localhost:8080/files/download/1745594498797_屏幕截图 2025-04-25 232130.png', 400.00, '拉布拉多犬起源于加拿大纽芬兰岛，最初由当地渔民培育，用于辅助捕鱼和狩猎水禽。19世纪初，英国贸易商将这一犬种引入英国，逐渐发展成现代拉布拉多犬。因其出色的工作能力和温顺的性格，拉布拉多犬迅速受到欢迎，并成为全球最受欢迎的犬种之一。', '<p style=\"text-align: start;\"><strong>拉布拉多犬介绍</strong></p><p style=\"text-align: start;\"><strong>一、起源与历史</strong><br>拉布拉多犬起源于加拿大纽芬兰岛，最初由当地渔民培育，用于辅助捕鱼和狩猎水禽。19世纪初，英国贸易商将这一犬种引入英国，逐渐发展成现代拉布拉多犬。因其出色的工作能力和温顺的性格，拉布拉多犬迅速受到欢迎，并成为全球最受欢迎的犬种之一。</p><p style=\"text-align: start;\"><strong>二、外形特征</strong></p><ol><li style=\"text-align: start;\"><strong>体型</strong>：中大型犬种，体格健壮，肌肉发达。</li><li style=\"text-align: start;\"><strong>被毛</strong>：短而密实的双层被毛，具有防水功能。主要颜色有黑色、黄色、巧克力色，偶见米白色。</li><li style=\"text-align: start;\"><strong>头部</strong>：宽阔的头骨，明显的额段，杏仁状眼睛（多为棕色、黄色或黑色），耳朵紧贴脸颊自然下垂。</li><li style=\"text-align: start;\"><strong>身体</strong>：胸部厚实，腰部强壮，四肢直立，足爪结实有力，尾巴呈水獭尾状（根部粗、尾梢细）。</li></ol><p style=\"text-align: start;\"><strong>三、性格特点</strong></p><ol><li style=\"text-align: start;\"><strong>温顺友好</strong>：对人类和其他动物极其友善，尤其适合与儿童相处，被誉为“无攻击性犬种”之一。</li><li style=\"text-align: start;\"><strong>忠诚服从</strong>：对主人忠心耿耿，服从性高，易于训练，智商在犬类中排名第七（相当于6-7岁儿童）。</li><li style=\"text-align: start;\"><strong>活泼好动</strong>：精力旺盛，喜欢玩耍、奔跑和游泳，每天需1-2小时运动以保持身心健康。</li><li style=\"text-align: start;\"><strong>聪明易训</strong>：学习能力强，能快速掌握指令，常被训练为导盲犬、搜救犬、警犬等工作犬。</li></ol><p style=\"text-align: start;\"><strong>四、用途与价值</strong></p><ol><li style=\"text-align: start;\"><strong>工作犬</strong>：广泛用于导盲、搜救、搜毒、排爆等领域，因其出色的嗅觉、服从性和稳定性而备受信赖。</li><li style=\"text-align: start;\"><strong>家庭宠物</strong>：性格温顺、适应性强，能融入各种家庭环境，为生活带来欢乐和温暖。</li><li style=\"text-align: start;\"><strong>治疗犬</strong>：因其亲和力，常被用于医院、学校等场所，提供心理支持。</li></ol><p style=\"text-align: start;\"><strong>五、饲养建议</strong></p><ol><li style=\"text-align: start;\"><strong>饮食管理</strong>：定时定量喂食，避免肥胖（拉布拉多食量大，易发胖）。</li><li style=\"text-align: start;\"><strong>健康护理</strong>：按时接种疫苗、定期驱虫、体检，注意关节保护（如髋关节发育不良风险）。</li><li style=\"text-align: start;\"><strong>运动与训练</strong>：每天保证充足运动，进行社会化训练，培养良好行为习惯。</li><li style=\"text-align: start;\"><strong>毛发护理</strong>：短毛易打理，但需定期梳理，换毛季节注意清洁。</li></ol><p style=\"text-align: start;\"><strong>六、优缺点总结</strong></p><ul><li style=\"text-align: start;\"><strong>优点</strong>：性格温顺、智商高、适应性强、易于训练、毛发短易打理。</li><li style=\"text-align: start;\"><strong>缺点</strong>：掉毛严重、运动量大、食量大、存在遗传性疾病风险（如髋关节发育不良、白内障等）。</li></ul><p style=\"text-align: start;\"><strong>七、受欢迎程度</strong><br>拉布拉多犬在全球范围内极受欢迎，在美国已连续31年（1991-2021）蝉联最受欢迎犬种榜首。其亲和力、稳定性和多功能性使其成为家庭和工作的理想选择。</p><p style=\"text-align: start;\"><strong>结语</strong><br>拉布拉多犬以其温暖、忠诚、聪明的特质，成为无数家庭的挚爱伙伴和工作领域的得力助手。若您能提供足够的关爱、运动空间和时间，它必将回报您无条件的陪伴与守护。</p>', '上架', '是');
INSERT INTO `pet` VALUES (5, 20, 2, '鹦鹉', '雌性', 'http://localhost:8080/files/download/1745665718158_屏幕截图 2025-04-26 190821.png', 120.00, '鹦鹉是鹦形目（Psittaciformes）鸟类的统称，包含82属超过358种，是鸟纲中种类最丰富的科之一。它们广泛分布于全球热带与亚热带地区，从拉丁美洲的雨林到大洋洲的岛屿，甚至非洲草原与亚洲山地，都能见到这些色彩斑斓的飞羽精灵。', '<p><span style=\"color: rgb(6, 7, 31); background-color: rgb(253, 253, 254); font-size: 15px;\">鹦鹉是色彩鲜艳的鸟类，种类很多，生活在热带和亚热带地区。它们有弯弯的嘴巴，可以咬开坚果，还有对生的脚趾，能牢牢抓住树枝。鹦鹉喜欢吃种子、水果，有些还会吃虫子。它们很聪明，能学人说话，模仿各种声音。鹦鹉喜欢群居，互相梳理羽毛，繁殖时会跳特别的舞蹈。很多鹦鹉因为人类活动面临危险，我们要保护它们。鹦鹉是可爱又聪明的动物，给人们带来很多欢乐。</span></p>', '上架', '是');
INSERT INTO `pet` VALUES (6, 20, 6, '绿鬣蜥', '雄性', 'http://localhost:8080/files/download/1745666322277_屏幕截图 2025-04-26 191814.png', 99.90, '绿鬣蜥是雨林生态的“工程师”，通过啃食、筑巢、排泄影响植物分布；亦是“生命教科书”，完美诠释冷血动物的生存策略。', '<h3 style=\"text-align: start;\"><strong>绿鬣蜥：雨林里的“绿精灵”</strong></h3><p style=\"text-align: start;\"><strong>1. 模样与家底</strong></p><ul><li style=\"text-align: start;\"><strong>长相</strong>：1.5米长“大蜥蜴”，幼年嫩绿带黑纹，成年变灰绿，雄性有“红喉扇”（求偶时膨胀示威）和“背刺冠”，尾巴占身体2/3，能卷树枝、抽敌人。</li><li style=\"text-align: start;\"><strong>老家</strong>：中美洲雨林（墨西哥到巴西），爱住树冠层，靠尾巴和利爪“飞檐走壁”。</li></ul><p style=\"text-align: start;\"><strong>2. 吃喝生存术</strong></p><ul><li style=\"text-align: start;\"><strong>吃草达人</strong>：90%是素食（树叶、花朵、果子、仙人掌），胃里有“消化菌”分解植物纤维，但需大量喝水（常舔树叶露水）。</li><li style=\"text-align: start;\"><strong>“太阳能充电”</strong>：每天晒6小时太阳升体温，冷了就躲树荫，皮肤能防紫外线，眼睛有“防风镜膜”。</li><li style=\"text-align: start;\"><strong>逃跑技能</strong>：遇危险甩尾巴抽打、喷酸液，雄性张喉扇吓敌，断尾能再生（但新尾巴没骨头）。</li></ul><p style=\"text-align: start;\"><strong>3. 长大与繁殖</strong></p><ul><li style=\"text-align: start;\"><strong>卵生宝宝</strong>：雌性每年挖洞产15-40枚“乒乓球卵”，幼体破壳后独立生活，3-4年长成“大块头”。</li><li style=\"text-align: start;\"><strong>寿命</strong>：野外活10-15年，家养能到20岁（需大空间、UVB灯补钙，否则骨头软）。</li></ul><p style=\"text-align: start;\"><strong>4. 人类与它的“爱恨”</strong></p><ul><li style=\"text-align: start;\"><strong>宠物陷阱</strong>：幼体呆萌易买，但长大后脾气倔、体味大，被弃养后入侵美国佛罗里达，啃光植物、吃光小动物，挤垮本土物种。</li><li style=\"text-align: start;\"><strong>文化符号</strong>：玛雅人当它是“太阳神使者”，电影里常扮反派（如《里约大冒险》绿蜥蜴）。</li></ul><p style=\"text-align: start;\"><strong>5. 冷知识</strong></p><ul><li style=\"text-align: start;\"><strong>“假哭”真相</strong>：它“流泪”不是伤心，是排盐（类似鳄鱼）。</li><li style=\"text-align: start;\"><strong>肢体语言</strong>：点头是“你好”，张嘴是“警告”，求偶时雄性会疯狂点头+甩喉扇。</li></ul><p style=\"text-align: start;\"><strong>一句话总结</strong>：绿鬣蜥是雨林“素食侠客”，靠尾巴和智慧称霸树冠，但因人类买卖和弃养，沦为“生态入侵者”——爱它，就别放生！</p>', '上架', '是');
INSERT INTO `pet` VALUES (7, 20, 2, '蜜袋鼯', '雌性', 'http://localhost:8080/files/download/1745666563260_屏幕截图 2025-04-26 192236.png', 159.99, '蜜袋鼯是“夜行版树袋熊+飞天版仓鼠”的结合体，既需要细致照料，又能带来滑翔降落肩头的惊喜。若你愿意为它打造“雨林小窝”、适应“夜猫子”作息，它就会用一生的“口袋抱抱”治愈你！', '<h1 style=\"text-align: start;\"><strong>蜜袋鼯：揣在口袋里的“迷你飞鼠”</strong></h1><p style=\"text-align: start;\"><strong>一、基础档案</strong></p><ul><li style=\"text-align: start;\"><strong>学名</strong>：Petaurus breviceps</li><li style=\"text-align: start;\"><strong>原产地</strong>：澳大利亚东部、新几内亚及周边岛屿，常栖息于热带雨林树冠层</li><li style=\"text-align: start;\"><strong>体型</strong>：手掌大小（体长12-15cm，尾长16-21cm，体重80-160g），毛绒绒似“会动的毛球”</li><li style=\"text-align: start;\"><strong>寿命</strong>：家庭饲养5-15年（科学照料可达18岁，需恒温恒湿）</li></ul><p style=\"text-align: start;\"><strong>二、高萌颜值与技能</strong></p><ul><li style=\"text-align: start;\"><strong>外形亮点</strong>：</li><li style=\"text-align: start;\"><strong>超能力</strong>：</li></ul><p style=\"text-align: start;\"><strong>三、饲养指南</strong></p><ul><li style=\"text-align: start;\"><strong>“别墅”配置</strong>：</li><li style=\"text-align: start;\"><strong>吃货日常</strong>：</li><li style=\"text-align: start;\"><strong>行为训练</strong>：</li></ul><p style=\"text-align: start;\"><strong>四、冷知识库</strong></p><ul><li style=\"text-align: start;\"><strong>“袋鼠亲戚”</strong>：属有袋类动物，幼崽出生时仅花生大小，需爬进育儿袋喝奶70天</li><li style=\"text-align: start;\"><strong>“夜猫子”作息</strong>：黄昏至凌晨活跃，白天80%时间在睡觉，强行唤醒会“生气炸毛”</li><li style=\"text-align: start;\"><strong>“气味告白”</strong>：发情期雄性用唾液混合腺体油涂抹主人，留专属“爱的印记”</li><li style=\"text-align: start;\"><strong>“自残预警”</strong>：压力大时会拔毛、咬尾，需提供更多玩具和陪伴（推荐悬挂羽毛毽子、啃咬木串）</li></ul><p style=\"text-align: start;\"><strong>五、避坑指南</strong></p><ul><li style=\"text-align: start;\"><strong>“合法饲养”</strong>：国内需办理《野生动物驯养繁殖许可证》，人工繁育二代以上个体可家养</li><li style=\"text-align: start;\"><strong>“成双成对”</strong>：单养易抑郁，建议同笼养同性（防繁殖）或已绝育异性，幼体可暂时单养</li><li style=\"text-align: start;\"><strong>“医疗盲区”</strong>：国内异宠医院稀缺，需备基础药品（电解质粉、葡萄糖、止血粉），定期称重监测</li></ul>', '上架', '否');
INSERT INTO `pet` VALUES (8, 19, 5, '三花猫', '雌性', 'http://localhost:8080/files/download/1745666843651_屏幕截图 2025-04-26 192702.png', 300.00, '三花猫是基因随机性创造的“艺术杰作”，以母猫之躯承载双色基因，用斑驳毛色演绎生命概率之美。它们是“薛定谔的伴侣”——时而傲娇如女王，时而黏人似幼崽，但那份“开盲盒”般的独特性，恰是无数人甘愿沦为“猫奴”的理由。若你愿包容它的“小脾气”，它必以一生治愈你的“小确丧”！', '<h1 style=\"text-align: start;\"><strong>三花猫：基因彩蛋下的“猫界蒙娜丽莎”</strong></h1><p style=\"text-align: start;\"><strong>一、科学身份卡</strong></p><ul><li style=\"text-align: start;\"><strong>学名</strong>：Felis catus（家猫亚种）</li><li style=\"text-align: start;\"><strong>基因密码</strong>：三花色由X染色体上的橘色基因（O）与黑色基因（B）随机组合而成，<strong>99.9%为母猫</strong>（雄性需为XXY嵌合体，概率约1/3000）</li><li style=\"text-align: start;\"><strong>颜值公式</strong>：黑+橘+白=随机分布的“抽象派涂鸦”，毛色占比无固定比例，每只都是“限量版”</li></ul><p style=\"text-align: start;\"><strong>二、基因与外貌的“开盲盒”游戏</strong></p><ol><li style=\"text-align: start;\"><strong>毛色玄学</strong></li></ol><ul><li style=\"text-align: left;\"><strong>“撞色艺术”</strong>：橘色基因（显性）与黑色基因（显性）在X染色体上随机表达，白色为显性稀释基因（S）覆盖，形成斑驳色块</li><li style=\"text-align: left;\"><strong>雄性三花</strong>：若出现则为XXY嵌合体（克氏综合征），常伴发育异常（如隐睾、生育障碍），民间视为“幸运符”</li></ul><ol><li style=\"text-align: start;\"><strong>颜值亮点</strong></li></ol><ul><li style=\"text-align: left;\"><strong>“猫中油画”</strong>：毛色过渡自然，常见“围脖橘+后背黑+肚皮白”经典款，或“左脸橘右脸黑”的“阴阳脸”</li><li style=\"text-align: left;\"><strong>“眼瞳滤镜”</strong>：多为琥珀色、绿色或黄绿色，幼猫时期呈蓝膜（3月龄后褪去）</li></ul><p style=\"text-align: start;\"><strong>三、性格与行为的“矛盾体”</strong></p><ul><li style=\"text-align: start;\"><strong>“薛定谔的温柔”</strong>：</li><li style=\"text-align: left;\">60%三花猫兼具橘猫的慵懒与玳瑁的机敏，白天是“葛优瘫代言人”，夜晚化身“拆家特工”</li><li style=\"text-align: left;\">30%因基因杂合表现出“神经质甜心”特质：上一秒用脑袋蹭手求撸，下一秒突然“空手道飞踢”逗猫棒</li><li style=\"text-align: start;\"><strong>“社交双面刃”</strong>：</li><li style=\"text-align: left;\">对主人：依赖度两极分化（黏人精VS高冷御姐），幼猫期社会化训练决定终身性格</li><li style=\"text-align: left;\">对同类：因毛色复杂易被其他猫“孤立”，但擅长用“喵喵拳”单挑入侵者</li></ul><p style=\"text-align: start;\"><strong>四、健康与养护“避坑指南”</strong></p><ol><li style=\"text-align: start;\"><strong>基因优势</strong></li></ol><p style=\"text-align: start;\">抗病性强：三花色基因与免疫系统强关联，某研究显示其猫白血病病毒（FeLV）感染率较纯色猫低23%长寿体质：日本猫岛统计显示，三花猫平均寿命达17.6岁（纯色猫14.2岁）<br></p><p style=\"text-align: start;\">2<strong>.特殊需求</strong></p><p style=\"text-align: start;\">绝育优先：雄性三花因染色体异常易患泌尿疾病，建议6月龄前绝育饮食管理：橘色基因关联肥胖风险，需控制碳水摄入（干粮蛋白质≥35%，冻干复水喂食）行为矫正：针对“间歇性暴躁”，可用费洛蒙喷雾（Feliway）缓解焦虑，搭配漏食球消耗精力</p><p style=\"text-align: start;\"><strong>五、文化符号与“玄学”传说</strong></p><ul><li style=\"text-align: start;\"><strong>“招财猫”原型</strong>：日本招财猫左招福右招财，三花色（“三毛别笹”）对应“三德圆满”（福、禄、寿）</li><li style=\"text-align: start;\"><strong>“灵媒”体质</strong>：西方传说中三花猫能看见亡灵，苏格兰人认为其可治愈百日咳（旧时将三花毛皮铺于患儿胸口）</li><li style=\"text-align: start;\"><strong>“猫岛守护神”</strong>：日本田代岛仅允许三花猫居住，居民称其为“海神使者”，禁止投喂外来猫</li></ul><p style=\"text-align: start;\"><strong>六、冷知识库</strong></p><ul><li style=\"text-align: start;\"><strong>“毛色预言家”</strong>：三花猫幼崽出生时全身雪白，毛色随年龄增长“解锁”，6月龄定型</li><li style=\"text-align: start;\"><strong>“生育彩蛋”</strong>：三花母猫若与橘猫交配，有25%概率产下“梵色”（仅四肢/尾巴/头顶有色）小猫</li><li style=\"text-align: start;\"><strong>“学术网红”</strong>：2016年诺贝尔化学奖得主田中耕一的猫即为三花，其基因研究启发他开发“三花猫算法”优化蛋白质分离</li></ul>', '上架', '否');
INSERT INTO `pet` VALUES (9, 19, 5, '布偶猫', '雌性', 'http://localhost:8080/files/download/1745667056746_屏幕截图 2025-04-26 193046.png', 999.99, '布偶猫是基因与人类驯化史共同雕琢的“温柔艺术品”，以“猫界颜值天花板”之姿，用无条件的信任与依赖治愈都市人的孤独。若你渴望一只“会呼吸的毛绒玩偶”，且能提供稳定陪伴、科学养护与医疗储备，它必以一生“瘫软在你怀里”作为最高礼赞。但若你追求“猫主子”的高冷傲娇，或许需重新考虑——毕竟布偶猫的字典里，从未有过“独立”二字。', '<h3 style=\"text-align: start;\"><strong>布偶猫：猫界“行走的云朵”，用温柔定义优雅</strong></h3><p style=\"text-align: start;\"><strong>一、血统溯源：从加州车库到全球“仙女猫”</strong></p><ul><li style=\"text-align: start;\"><strong>起源故事</strong>：1960年代，美国加州繁育人安·贝克（Ann Baker）用白波斯猫、缅甸猫与伯曼猫杂交，培育出性情温顺、毛色如绸的布偶猫（Ragdoll），名字源于其被抱起时“全身瘫软如布偶”的特性。</li><li style=\"text-align: start;\"><strong>品种认证</strong>：1993年获CFA（国际爱猫联合会）冠军认证，2003年进入中国，现已成全球最受欢迎的宠物猫品种之一。</li></ul><p style=\"text-align: start;\"><strong>二、颜值密码：用科学解释“仙女下凡”</strong></p><ul><li style=\"text-align: start;\"><strong>基因彩蛋</strong>：</li><li style=\"text-align: left;\"><strong>重点色基因（Siamese）</strong>：受温度影响，体表低温区（四肢、面部、尾部）色素沉积，形成“暹罗猫式”深色面具，高温区（躯干）则保持浅色。</li><li style=\"text-align: left;\"><strong>白色稀释基因（Dilute）</strong>：控制黑色素浓度，使毛色呈现奶油白、海豹棕、巧克力棕等低饱和度色系，自带“柔光滤镜</li><li style=\"text-align: start;\"><strong>外貌特征</strong>：</li><li style=\"text-align: left;\"><strong>体型</strong>：大型猫（母猫4-7kg，公猫6-9kg），肌肉发达但骨架纤长，抱起时如“会呼吸的毛绒抱枕”。</li><li style=\"text-align: left;\"><strong>五官</strong>：杏仁状蓝眼（越深邃越纯正），楔形头颅配短鼻梁，耳尖微圆，表情自带“无辜感”。</li><li style=\"text-align: left;\"><strong>毛发</strong>：中长双层被毛（底层绒毛厚实，表层护毛防水），触感如丝绸，抗打结能力强，每周梳理1次即可保持蓬松。</li></ul><p style=\"text-align: start;\"><strong>三、性格图谱：用“反差萌”征服人类</strong></p><ul><li style=\"text-align: start;\"><strong>核心标签</strong>：</li><li style=\"text-align: left;\"><strong>猫界狗魂”</strong>：随叫随到，能玩“捡球游戏”，部分个体可训练戴牵引绳散步。</li><li style=\"text-align: left;\"><strong>“温柔巨人”</strong>：对儿童、老人、其他宠物高度包容，允许婴儿抓挠、狗狗舔鼻，甚至“自愿当枕头”。</li><li style=\"text-align: left;\"><strong>“压力克星”</strong>：多项研究显示，抚摸布偶猫可降低30%皮质醇水平，其呼噜声（20-140Hz）对失眠、焦虑有物理治疗作用。</li><li style=\"text-align: start;\"><strong>行为偏好</strong>：</li><li style=\"text-align: left;\"><strong>黏人指数</strong>：★★★★★（需主人持续关注，若被冷落可能抑郁绝食）</li><li style=\"text-align: left;\"><strong>活跃时段</strong>：清晨与黄昏（野性残留），其余时间“躺平任撸”，适合“996”上班族。</li><li style=\"text-align: left;\"><strong>智商表现</strong>：可理解简单指令（“握手”“坐下”），能开抽屉、按马桶冲水键，但常因“懒癌发作”装傻。</li></ul><p style=\"text-align: start;\"><strong>四、科学养护：打造“仙女猫”的幸福星球</strong></p><ul><li style=\"text-align: start;\"><strong>居住环境</strong>：</li><li style=\"text-align: left;\"><strong>空间</strong>：≥15㎡独立房间（布偶猫领地意识强，需专属地盘），配备垂直猫爬架（满足登高欲望）。</li><li style=\"text-align: left;\"><strong>温控</strong>：18-25℃恒温，冬季提供电热毯（禁止用暖宝宝，易烫伤），夏季避免阳光直射。</li><li style=\"text-align: start;\"><strong>饮食管理</strong>：</li><li style=\"text-align: left;\"><strong>主粮</strong>：高蛋白（≥40%）、中脂肪（15%-20%）无谷猫粮，推荐渴望、百利等品牌，幼猫需额外补充赖氨酸（防疱疹病毒）。</li><li style=\"text-align: left;\"><strong>加餐</strong>：每周2-3次熟鸡胸肉、三文鱼（补充Omega-3），每日1勺山羊奶（防乳糖不耐受）。</li><li style=\"text-align: left;\"><strong>禁忌</strong>：巧克力、洋葱、葡萄、酒精，误食可能致死。</li><li style=\"text-align: start;\"><strong>健康监控</strong>：</li><li style=\"text-align: left;\"><strong>高发疾病</strong>：</li><li style=\"text-align: left;\"><strong>疫苗驱虫</strong>：2月龄起接种猫三联+狂犬疫苗，每3个月口服大宠爱驱虫（内外同驱）。</li></ul><p style=\"text-align: start;\"><strong>五、冷知识库：解锁布偶猫的“隐藏技能”</strong></p><ul><li style=\"text-align: start;\"><strong>“痛觉迟钝”之谜</strong>：因基因缺陷导致神经传导速度比普通猫慢17%，摔落时反应迟缓，需封窗防坠楼。</li><li style=\"text-align: start;\"><strong>“变色龙”体质</strong>：幼猫为纯白，6月龄后重点色逐渐显现，2岁定型，冬季毛色比夏季深2个色号。</li><li style=\"text-align: start;\"><strong>“社交牛人”认证</strong>：布偶猫是唯一被FAA（美国联邦航空局）批准可进入驾驶舱的宠物猫（曾用于缓解飞行员压力）。</li><li style=\"text-align: start;\"><strong>“经济贡献”</strong>：日本数据显示，养布偶猫的家庭年均宠物消费比养其他猫高42%，其中“仙女猫写真集”“云吸猫直播打赏”占比超30%。</li></ul><p style=\"text-align: start;\"><strong>六、避坑指南：新手养布偶的“智商税”预警</strong></p><ul><li style=\"text-align: start;\"><strong>血统陷阱</strong>：</li><li style=\"text-align: left;\">警惕“后院猫舍”用暹罗、英短冒充布偶，正规猫舍需提供CFA/WCF血统证书、基因检测报告、疫苗本。</li><li style=\"text-align: left;\">重点色≠布偶猫，需确认双亲为注册布偶，且幼猫有“五代族谱”。</li><li style=\"text-align: start;\"><strong>颜值误区</strong>：</li><li style=\"text-align: left;\">手套色”布偶（四肢雪白，身体重点色）≠品相差，反而是经典毛色之一。</li><li style=\"text-align: left;\">毛色对称度不影响健康，不必追求“完美面具”，过度近亲繁殖易致遗传病。</li><li style=\"text-align: start;\"><strong>成本预警</strong>：</li><li style=\"text-align: left;\">购买价：宠物级8000-15000元，赛级20000元起，绝育后价格减半。</li><li style=\"text-align: left;\">年均花费：食品3000元+医疗2000元+用品1000元=6000元起（未含绝育/急诊费用）。</li></ul>', '上架', '否');
INSERT INTO `pet` VALUES (10, 14, 8, '智利红玫瑰蜘蛛', '无性别', 'http://localhost:8080/files/download/1745667443155_屏幕截图 2025-04-26 193714.png', 49.90, '智利红玫瑰蜘蛛是“沙漠生存教科书”与“新手友好型宠物”的完美结合，以超长寿命、低维护成本、治愈系蜕变过程，成为都市“赛博游牧族”的精神寄托。若你渴望一只无需遛弯、不扰民、能静观其变的“活体解压神器”，且能接受其“非主流颜值”与踢毛防御机制，它将以一生“慢节奏蜕变”教会你——真正的陪伴，无需热烈，只需岁月静好。', '<h3 style=\"text-align: start;\"><strong>智利红玫瑰蜘蛛（Grammostola porteri）：新手友好的“沙漠艺术家”</strong></h3><p style=\"text-align: start;\"><strong>一、物种档案：从安第斯山麓到全球宠物圈</strong></p><ul><li style=\"text-align: start;\"><strong>原产地</strong>：智利北部阿塔卡马沙漠边缘（世界最干燥地区之一），栖息于石缝、枯木洞穴</li><li style=\"text-align: start;\"><strong>体型</strong>：成体足展13-15cm（母体＞公体），体重30-50g，浑身覆盖“绒感刚毛”</li><li style=\"text-align: start;\"><strong>寿命</strong>：母体15-25年（可传代陪伴），公体5-8年（成熟后2年内死亡，因交配耗尽能量）</li></ul><p style=\"text-align: start;\"><strong>二、颜值与生存智慧</strong></p><ul><li style=\"text-align: start;\"><strong>视觉冲击</strong>：</li><li style=\"text-align: left;\"><strong>毛色美学</strong>：幼体棕灰色，成年后蜕变为“脏粉色-酒红色”渐变体，腹部缀黑色几何纹（每只花纹独一无二）</li><li style=\"text-align: left;\"><strong>“红毯级”毛发</strong>：足部密布防滑刚毛（2000根/cm²），躯干绒毛可吸收紫外线，沙漠烈日下仍保持体表凉爽</li><li style=\"text-align: start;\"><strong>沙漠生存术</strong>：</li><li style=\"text-align: left;\"><strong>“龟息”大师</strong>：耐旱性超强，可连续6个月不饮水（靠食物代谢水+夜间凝结露水），湿度＞70%易患软脚病</li><li style=\"text-align: left;\"><strong>“隐身术”</strong>：体色随环境变色（沙漠土色→洞穴灰褐色），静止时完美融入背景，躲避天敌与捕食</li><li style=\"text-align: left;\"><strong>“震感预警”</strong>：足部刚毛能感知0.001毫米级地面震动，提前30秒预判威胁，迅速钻入躲避洞</li></ul><p style=\"text-align: start;\"><strong>三、新手友好型饲养指南</strong></p><ol><li style=\"text-align: start;\"><strong>“荒漠别墅”搭建</strong></li></ol><ul><li style=\"text-align: left;\"><strong>容器</strong>：30×20×20cm以上亚克力饲养箱（透气防逃），底部铺5cm椰土+蛭石混合垫材（模拟沙漠地质）</li><li style=\"text-align: left;\"><strong>躲避屋</strong>：树皮洞穴/陶罐（直径＞蜘蛛体长1.5倍），入口斜向布置防卡脚</li><li style=\"text-align: left;\"><strong>湿度控制</strong>：湿度计+喷壶（湿度40%-60%），每周喷雾1次（喷墙壁不喷体表），高温区配鹅卵石降温垫</li><li style=\"text-align: left;\"><strong>光照陷阱</strong>：无需UVB灯，避免阳光直射（可致脱水），用陶瓷加热灯维持25-28℃恒温</li></ul><ol><li style=\"text-align: start;\"><strong>“沙漠盛宴”食谱</strong></li></ol><ul><li style=\"text-align: left;\"><strong>主餐</strong>：幼体（1-3cm）喂食樱桃蟑螂/面包虫（剪头防钻胃），成体（5cm+）可投喂杜比亚蟑螂/乳鼠（每月1只）</li><li style=\"text-align: left;\"><strong>投喂频率</strong>：幼体3天1餐，成体7-10天1餐（过量喂食易猝死），进食后24小时清理残骸防霉变</li><li style=\"text-align: left;\"><strong>禁忌食物</strong>：萤火虫（含剧毒）、野生昆虫（农药残留）、人类食物（盐分致肾衰）</li></ul><ol><li style=\"text-align: start;\"><strong>行为训练与互动</strong></li></ol><ul><li style=\"text-align: left;\"><strong>“信任建立”</strong>：用镊子喂食，保持30cm安全距离，连续1个月后尝试指尖递食（戴防咬手套）</li><li style=\"text-align: left;\"><strong>“放风安全”</strong>：仅限蜕皮后体态轻盈时，在封闭塑料箱内活动（铺报纸防逃逸），禁止裸手抓握</li><li style=\"text-align: left;\"><strong>“清洁仪式”</strong>：提供湿润棉球供其自行清理口器，人工清理需用婴儿棉签蘸纯净水轻拭</li></ul><p style=\"text-align: start;\"><strong>四、健康预警与应急处理</strong></p><ul><li style=\"text-align: start;\"><strong>“红绿灯”健康指标</strong>：</li><li style=\"text-align: left;\"><strong>绿灯</strong>：腹部饱满有弹性（非过度隆起），活动敏捷，拒食后1周内恢复食欲</li><li style=\"text-align: left;\"><strong>黄灯</strong>：腹部凹陷（脱水）、持续拒食（＞2周）、行动迟缓（需排查温度/湿度）</li><li style=\"text-align: left;\"><strong>红灯</strong>：足部发黑溃烂（软脚病）、腹部有褐色斑点（寄生虫）、拒食+频繁踢毛（应激反应）</li><li style=\"text-align: start;\"><strong>常见病急救包</strong>：</li><li style=\"text-align: left;\"><strong>软脚病</strong>：换干燥垫材，停食静养，口服电解质粉（1:500稀释）</li><li style=\"text-align: left;\"><strong>寄生虫</strong>：用宠物专用驱虫药（含吡喹酮成分）喷洒垫材，连续3次驱虫周期</li><li style=\"text-align: left;\"><strong>蜕皮障碍</strong>：提供湿润苔藓区，用手术刀片轻剥卡住的老皮（仅限卡住＞48小时）</li></ul><p style=\"text-align: start;\"><strong>五、冷知识库：颠覆认知的“沙漠哲学”</strong></p><ul><li style=\"text-align: start;\"><strong>“踢毛防御”</strong>：受惊时用后足猛踢腹部刚毛（含微毒角蛋白），人类接触后红肿瘙痒（敏感人群可引发哮喘），需用胶带粘除</li><li style=\"text-align: start;\"><strong>“断肢再生”</strong>：自切足部后，下次蜕皮可长出更短的新足（功能完整但无刚毛），连续断肢3次后永久残疾</li><li style=\"text-align: start;\"><strong>“暴风雪变异”</strong>：人工选育出的白化体（通体雪白+红眼），但免疫力较野生型弱30%，饲养需更精细</li><li style=\"text-align: start;\"><strong>“经济学价值”</strong>：单只母体一生可产1000+只后代，欧洲宠物市场价稳定在30-50欧元/只（幼体）</li></ul><p style=\"text-align: start;\"><strong>六、新手避坑指南</strong></p><ul><li style=\"text-align: start;\"><strong>“合法性”核查</strong>：国内允许饲养非保育类捕鸟蛛（红玫瑰属“三有”名录外），但需避开巴西黑、油彩粉趾等CITES附录Ⅱ物种</li><li style=\"text-align: start;\"><strong>“性别误判”陷阱</strong>：母体腹部有“储精囊”（硬质凸起），公体触肢末端有“精拳”（交配器官），幼体需等3次蜕皮后才能分辨</li><li style=\"text-align: start;\"><strong>“智商税”预警</strong>：</li><li style=\"text-align: left;\">拒绝“开食药”（应激时强行喂食死亡率＞80%）</li><li style=\"text-align: left;\">慎购“沙漠造景套餐”（多数含有毒彩石/假草）</li><li style=\"text-align: left;\">远离“基因优化”宣传（近亲繁殖易致短命）</li></ul>', '上架', '否');
INSERT INTO `pet` VALUES (11, 14, 8, '兰花螳螂', '无性别', 'http://localhost:8080/files/download/1745667700123_屏幕截图 2025-04-26 194133.png', 999.90, '“它是雨林用亿万年雕琢的‘死亡之花’，不是人类掌心的‘玩物’。”\n（若爱，请让它在纪录片与保护区中自由绽放）', '<h1 style=\"text-align: center;\">兰花螳螂：雨林中的“拟态花仙子”</h1><h4 style=\"text-align: start;\"><strong>物种档案</strong></h4><ul><li style=\"text-align: start;\">学名：Hymenopus coronatus</li><li style=\"text-align: start;\">原生地：东南亚热带雨林（马来西亚、印尼、泰国）</li><li style=\"text-align: start;\">体型：雌性成体6-7cm，雄性仅2.5-3cm</li><li style=\"text-align: start;\">寿命：野外6-8个月，人工饲养可延至1年</li></ul><h4 style=\"text-align: start;\"><strong>色彩与形态</strong></h4><ul><li style=\"text-align: start;\">幼体拟态花瓣：粉白相间，触角如花蕊</li><li style=\"text-align: start;\">成体雌性拟态兰花：乳白至淡粉色，前胸背板如萼片</li><li style=\"text-align: start;\">动态调色：随湿度、年龄变化体色与花纹</li></ul><h4 style=\"text-align: start;\"><strong>生存智慧</strong></h4><ul><li style=\"text-align: start;\">伏击战术：专挑盛开兰花栖息，0.1秒内捕食授粉昆虫</li><li style=\"text-align: start;\">猎杀清单：蜜蜂、蝴蝶为主食，偶捕小型蛙类</li><li style=\"text-align: start;\">交配博弈：雌性交配后90%概率攻击雄性</li></ul><h4 style=\"text-align: start;\"><strong>人工饲养要点</strong></h4><ul><li style=\"text-align: start;\">环境：高湿度（80%-90%）、25-28℃恒温，模拟雨林造景</li><li style=\"text-align: start;\">饮食：果蝇、樱桃蟑螂为主，忌过量喂食</li><li style=\"text-align: start;\">健康风险：软脚症、蜕皮障碍需警惕</li></ul><h4 style=\"text-align: start;\"><strong>冷知识</strong></h4><ul><li style=\"text-align: start;\">体表微绒毛易沾花粉，需远离强致敏植物</li><li style=\"text-align: start;\">野外种群10年下降35%，栖息地丧失为主因</li></ul><h4 style=\"text-align: start;\"><strong>保护与争议</strong></h4><ul><li style=\"text-align: start;\">CITES附录Ⅱ物种，跨境交易需许可证</li><li style=\"text-align: start;\">市售个体90%为野生捕获，运输存活率不足40%</li></ul>', '上架', '否');
INSERT INTO `pet` VALUES (12, 14, 9, '章鱼', '无性别', 'http://localhost:8080/files/download/1747817532250_屏幕截图 2025-05-21 165145.png', 299.00, '学名：章鱼属于软体动物门（Mollusca）、头足纲（Cephalopoda）、八腕目（Octopoda），全球已知约300种。', '<h3 style=\"text-align: start;\"><span style=\"font-size: 24px;\"><strong>章鱼详情</strong></span></h3><p style=\"text-align: start;\"><strong>分类与特征</strong></p><ul><li style=\"text-align: start;\">软体动物门、头足纲，全球约300种，无硬质内骨骼，八条带吸盘的触腕，身体柔软可变形。</li><li style=\"text-align: start;\">广泛分布于全球海洋，栖息地从浅海到深海。</li></ul><p style=\"text-align: start;\"><strong>智慧与行为</strong></p><ul><li style=\"text-align: start;\">头足纲中智力顶尖，具备复杂问题解决能力、观察学习和模仿行为，记忆能力突出。</li><li style=\"text-align: start;\">拟态伪装高手，能瞬间变色、变形，模仿其他生物或环境；遇险时喷墨逃生。</li></ul><p style=\"text-align: start;\"><strong>核心亮点</strong></p><ul><li style=\"text-align: start;\">海洋“伪装大师”与“智慧担当”，兼具生存策略与认知能力。</li></ul>', '上架', '否');

-- ----------------------------
-- Table structure for pet_shop
-- ----------------------------
DROP TABLE IF EXISTS `pet_shop`;
CREATE TABLE `pet_shop`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '账号',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '名称',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '密码',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '头像',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '手机号',
  `sell_pet` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '销售宠物',
  `address` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '地址',
  `introduce` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '介绍',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮件',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '角色',
  `practice_license` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '认证图片',
  `principal_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '负责人名称',
  `principal_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '负责人身份证号',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '认证状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '宠物店信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of pet_shop
-- ----------------------------
INSERT INTO `pet_shop` VALUES (14, 'P001', '向日葵', '11', 'http://localhost:8080/files/download/1745480812129_屏幕截图 2025-04-24 154542.png', '11456876421', '[\"鱼类\",\"昆虫类\"]', '中国·杭州市西湖区云栖小镇云梦路66号', '「向日葵」成立于2018年，是一家倡导\"宠物友好型生活\"的复合式宠物服务空间。我们致力于为宠物提供全生命周期的贴心服务，同时为养宠人打造交流互动的温暖社区。', '2468974351@qq.com', 'PETSHOP', 'http://localhost:8080/files/download/1745498550768_屏幕截图 2025-04-24 204219.png', '王小花', '564514984165168811', '审核成功');
INSERT INTO `pet_shop` VALUES (19, 'P002', '酷狗宠物店', '11', 'http://localhost:8080/files/download/1745592261576_屏幕截图 2025-04-25 223741.png', '16876547645', '[\"哺乳类\"]', '中国·上海市浦东新区珊瑚湾路88号海滨广场B座102室', '酷狗宠物店是一家以“打造人宠和谐生活”为理念的综合性宠物服务空间，致力于为宠物和主人提供一站式优质体验。店铺坐拥200㎡的温馨空间，采用环保材料装修，搭配绿植与宠物主题壁画，营造出舒适自然的氛围', '', 'PETSHOP', 'http://localhost:8080/files/download/1745592455387_屏幕截图 2025-04-24 204219.png', '王太一', '456879461315111111', '审核成功');
INSERT INTO `pet_shop` VALUES (20, 'P003', '萌宠乐园', '11', 'http://localhost:8080/files/download/1745664741286_屏幕截图 2025-04-20 142147.png', '010-1234567', '[\"鸟类\",\"爬行类\"]', '北京市朝阳区爱宠路36号（近朝阳公园东门，宠物主题商业街2层）', '萌宠乐园宠物会所是一家集宠物美容、寄养托管、用品零售及医疗咨询于一体的综合性宠物服务机构。我们以“用爱心呵护每一只毛孩子”为理念，致力于为宠物和主人打造温馨、专业的互动空间。', '489146486@cc.com', 'PETSHOP', 'http://localhost:8080/files/download/1745665306600_屏幕截图 2025-04-24 204219.png', '白云', '897684685479416168', '审核成功');

-- ----------------------------
-- Table structure for pet_type
-- ----------------------------
DROP TABLE IF EXISTS `pet_type`;
CREATE TABLE `pet_type`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '类型名称',
  PRIMARY KEY (`id` DESC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '宠物类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pet_type
-- ----------------------------
INSERT INTO `pet_type` VALUES (9, '鱼类');
INSERT INTO `pet_type` VALUES (8, '昆虫类');
INSERT INTO `pet_type` VALUES (7, '两栖类');
INSERT INTO `pet_type` VALUES (6, '爬行类');
INSERT INTO `pet_type` VALUES (5, '哺乳类');
INSERT INTO `pet_type` VALUES (2, '鸟类');

-- ----------------------------
-- Table structure for shopping_cart
-- ----------------------------
DROP TABLE IF EXISTS `shopping_cart`;
CREATE TABLE `shopping_cart`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT '用户ID',
  `goods_id` int NOT NULL COMMENT '商品ID（宠物或用品）',
  `type_id` int NOT NULL COMMENT '商品类型（宠物或用品）',
  `quantity` int NOT NULL DEFAULT 1 COMMENT '数量',
  `added_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `shopping_cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `shopping_cart_chk_1` CHECK (`quantity` > 0)
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shopping_cart
-- ----------------------------
INSERT INTO `shopping_cart` VALUES (19, 3, 7, 16, 3, '2025-08-08 20:11:53');
INSERT INTO `shopping_cart` VALUES (20, 3, 11, 13, 3, '2025-08-08 20:16:49');
INSERT INTO `shopping_cart` VALUES (21, 4, 12, 13, 4, '2025-08-08 20:28:03');

-- ----------------------------
-- Table structure for slideshow
-- ----------------------------
DROP TABLE IF EXISTS `slideshow`;
CREATE TABLE `slideshow`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `pet_id` int NULL DEFAULT NULL COMMENT '关联宠物',
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图片',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '轮播图' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of slideshow
-- ----------------------------
INSERT INTO `slideshow` VALUES (1, 9, 'http://localhost:8080/files/download/1753788862758_屏幕截图 2025-07-29 193411.png');
INSERT INTO `slideshow` VALUES (2, 10, 'http://localhost:8080/files/download/1753788997690_屏幕截图 2025-07-29 193627.png');
INSERT INTO `slideshow` VALUES (3, 11, 'http://localhost:8080/files/download/1753789068274_屏幕截图 2025-07-29 193739.png');
INSERT INTO `slideshow` VALUES (4, 7, 'http://localhost:8080/files/download/1753789119177_屏幕截图 2025-07-29 193831.png');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '名字',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '手机号',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '普通用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (3, 'U001', '11', 'USER', '吉吉国王', 'http://localhost:8080/files/download/1747468625562_屏幕截图 2025-05-17 155651.png', '15698547647', '7894368419@qq.com');
INSERT INTO `user` VALUES (4, 'U002', '11', 'USER', '熊大', 'http://localhost:8080/files/download/1753707304457_屏幕截图 2025-07-28 205453.png', '15987463542', '');
INSERT INTO `user` VALUES (5, 'U003', '11', 'USER', '熊二', 'http://localhost:8080/files/download/1754651552798_屏幕截图 2025-08-08 191221.png', NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;
