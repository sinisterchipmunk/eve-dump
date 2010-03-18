DROP TABLE IF EXISTS `agtAgentTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `agtAgentTypes` (
  `agentTypeID` tinyint(3) unsigned NOT NULL,
  `agentType` varchar(50) default NULL,
  PRIMARY KEY  (`agentTypeID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agtAgentTypes`
--

LOCK TABLES `agtAgentTypes` WRITE;
/*!40000 ALTER TABLE `agtAgentTypes` DISABLE KEYS */;
INSERT INTO `agtAgentTypes` VALUES (1,'NonAgent');
INSERT INTO `agtAgentTypes` VALUES (2,'BasicAgent');
INSERT INTO `agtAgentTypes` VALUES (3,'TutorialAgent');
INSERT INTO `agtAgentTypes` VALUES (4,'ResearchAgent');
INSERT INTO `agtAgentTypes` VALUES (5,'CONCORDAgent');
INSERT INTO `agtAgentTypes` VALUES (6,'GenericStorylineMissionAgent');
INSERT INTO `agtAgentTypes` VALUES (7,'StorylineMissionAgent');
INSERT INTO `agtAgentTypes` VALUES (8,'EventMissionAgent');

