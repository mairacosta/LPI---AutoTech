--
-- Table structure for table `carro`
--

DROP TABLE IF EXISTS `carro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carro` (
  `id` int NOT NULL AUTO_INCREMENT,
  `placa` varchar(8) NOT NULL,
  `ano` varchar(4) DEFAULT NULL,
  `cor` varchar(45) DEFAULT NULL,
  `carroModelo_id` int NOT NULL,
  `cliente_id` int NOT NULL,
  PRIMARY KEY (`id`,`carroModelo_id`,`cliente_id`),
  UNIQUE KEY `placa_UNIQUE` (`placa`),
  KEY `fk_carro_carroModelo1_idx` (`carroModelo_id`),
  KEY `fk_carro_cliente_id_idx` (`cliente_id`),
  CONSTRAINT `fk_carro_carroModelo1` FOREIGN KEY (`carroModelo_id`) REFERENCES `carromodelo` (`id`),
  CONSTRAINT `fk_carro_cliente_id` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `carromodelo`
--

DROP TABLE IF EXISTS `carromodelo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carromodelo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nomeModelo` varchar(45) DEFAULT NULL,
  `fabricante_id` int NOT NULL,
  PRIMARY KEY (`id`,`fabricante_id`),
  KEY `fk_carroModelo_fabricante1_idx` (`fabricante_id`),
  CONSTRAINT `fk_carroModelo_fabricante1` FOREIGN KEY (`fabricante_id`) REFERENCES `fabricante` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cpf` varchar(45) NOT NULL,
  `nome` varchar(45) DEFAULT NULL,
  `usuario_id` int NOT NULL,
  PRIMARY KEY (`id`,`usuario_id`),
  UNIQUE KEY `cpf_UNIQUE` (`cpf`),
  KEY `fk_cliente_usuario1_idx` (`usuario_id`),
  CONSTRAINT `fk_cliente_usuario1` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `endereco`
--

DROP TABLE IF EXISTS `endereco`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `endereco` (
  `id` int NOT NULL AUTO_INCREMENT,
  `rua` varchar(45) DEFAULT NULL,
  `numero` varchar(45) DEFAULT NULL,
  `complemento` varchar(45) DEFAULT NULL,
  `bairro` varchar(45) DEFAULT NULL,
  `usuario_id` int NOT NULL,
  PRIMARY KEY (`id`,`usuario_id`),
  KEY `fk_Endereço_usuario1_idx` (`usuario_id`),
  CONSTRAINT `fk_Endereço_usuario1` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fabricante`
--

DROP TABLE IF EXISTS `fabricante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fabricante` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `funcionario`
--

DROP TABLE IF EXISTS `funcionario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `funcionario` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) DEFAULT NULL,
  `usuario_id` int NOT NULL,
  PRIMARY KEY (`id`,`usuario_id`),
  KEY `fk_funcionario_usuario1_idx` (`usuario_id`),
  CONSTRAINT `fk_funcionario_usuario1` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ordemservico`
--

DROP TABLE IF EXISTS `ordemservico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordemservico` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status` varchar(45) DEFAULT NULL,
  `data` datetime DEFAULT NULL,
  `funcionario_id` int NOT NULL,
  `carro_id` int NOT NULL,
  PRIMARY KEY (`id`,`funcionario_id`,`carro_id`),
  KEY `fk_ordemServico_funcionario1_idx` (`funcionario_id`),
  KEY `fk_ordemServico_carro_idx` (`carro_id`),
  CONSTRAINT `fk_ordemServico_carro` FOREIGN KEY (`carro_id`) REFERENCES `carro` (`id`),
  CONSTRAINT `fk_ordemServico_funcionario1` FOREIGN KEY (`funcionario_id`) REFERENCES `funcionario` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `servico`
--

DROP TABLE IF EXISTS `servico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `servico` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) DEFAULT NULL,
  `preco` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `servico_has_ordemservico`
--

DROP TABLE IF EXISTS `servico_has_ordemservico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `servico_has_ordemservico` (
  `id` int NOT NULL AUTO_INCREMENT,
  `servico_id` int NOT NULL,
  `ordemServico_id` int NOT NULL,
  PRIMARY KEY (`id`,`servico_id`,`ordemServico_id`),
  KEY `fk_servico_has_ordemServico_ordemServico1_idx` (`ordemServico_id`),
  KEY `fk_servico_has_ordemServico_servico1_idx` (`servico_id`),
  CONSTRAINT `fk_servico_has_ordemServico_ordemServico1` FOREIGN KEY (`ordemServico_id`) REFERENCES `ordemservico` (`id`),
  CONSTRAINT `fk_servico_has_ordemServico_servico1` FOREIGN KEY (`servico_id`) REFERENCES `servico` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `telefone`
--

DROP TABLE IF EXISTS `telefone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `telefone` (
  `id` int NOT NULL AUTO_INCREMENT,
  `telefone` varchar(45) NOT NULL,
  `usuario_id` int NOT NULL,
  PRIMARY KEY (`id`,`usuario_id`),
  UNIQUE KEY `telefone_UNIQUE` (`telefone`),
  KEY `fk_telefone_usuario1_idx` (`usuario_id`),
  CONSTRAINT `fk_telefone_usuario1` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(45) NOT NULL,
  `password` varchar(45) DEFAULT NULL,
  `tipo` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

