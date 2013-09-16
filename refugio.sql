SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `refugio` ;
CREATE SCHEMA IF NOT EXISTS `refugio` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `refugio` ;

-- -----------------------------------------------------
-- Table `refugio`.`rol_rol`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `refugio`.`rol_rol` ;

CREATE TABLE IF NOT EXISTS `refugio`.`rol_rol` (
  `rol_id` INT NOT NULL COMMENT 'ID de los roles',
  `rol_nombre` VARCHAR(20) NOT NULL COMMENT 'Nombre del rol',
  `rol_descripcion` VARCHAR(60) NULL COMMENT 'Descripcion del rol ingresado',
  PRIMARY KEY (`rol_id`))
ENGINE = InnoDB
COMMENT = 'Roles de los usuarios a ingresar al sitio';


-- -----------------------------------------------------
-- Table `refugio`.`usr_usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `refugio`.`usr_usuario` ;

CREATE TABLE IF NOT EXISTS `refugio`.`usr_usuario` (
  `usr_id` INT NOT NULL COMMENT 'ID del usuario',
  `usr_usuarios` VARCHAR(30) NOT NULL COMMENT 'Username de acceso al sitio',
  `usr_nombre1` VARCHAR(20) NOT NULL COMMENT '1er nombre real del usuario',
  `usr_nombre2` VARCHAR(20) NULL COMMENT '2o nombre real del usuario',
  `usr_apellido1` VARCHAR(20) NOT NULL COMMENT '1er apellido real del usuario',
  `usr_apellido2` VARCHAR(20) NULL COMMENT '2o apellido real del usuario',
  `usr_rol_id` INT NOT NULL COMMENT 'Llave foranea',
  `usr_passwd` VARCHAR(100) NOT NULL COMMENT 'Contraseña de acceso al sitio',
  PRIMARY KEY (`usr_id`, `usr_rol_id`),
  INDEX `fk_usr_usuario_rol_rol_idx` (`usr_rol_id` ASC),
  CONSTRAINT `fk_usr_rol_id`
    FOREIGN KEY (`usr_rol_id`)
    REFERENCES `refugio`.`rol_rol` (`rol_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Datos de usuario del sitio';


-- -----------------------------------------------------
-- Table `refugio`.`mas_mascotas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `refugio`.`mas_mascotas` ;

CREATE TABLE IF NOT EXISTS `refugio`.`mas_mascotas` (
  `mas_id` INT NOT NULL COMMENT 'ID de las mascotas',
  `mas_tipo` VARCHAR(25) NOT NULL COMMENT 'Tipo de mascota',
  PRIMARY KEY (`mas_id`))
ENGINE = InnoDB
COMMENT = 'Mascotas que puede manejar un refugio';


-- -----------------------------------------------------
-- Table `refugio`.`vac_vacunas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `refugio`.`vac_vacunas` ;

CREATE TABLE IF NOT EXISTS `refugio`.`vac_vacunas` (
  `vac_id` INT NOT NULL COMMENT 'ID de las vacunas',
  `vac_nombre` VARCHAR(20) NOT NULL COMMENT 'Nombre de la vacuna',
  `vac_tipo` VARCHAR(20) NOT NULL COMMENT 'Tipo de vacuna aplicada',
  `vac_descripcion` VARCHAR(45) NULL COMMENT 'Descripcion de la vacuna aplicada',
  PRIMARY KEY (`vac_id`))
ENGINE = InnoDB
COMMENT = 'Vacunas colocadas a las mascotas';


-- -----------------------------------------------------
-- Table `refugio`.`esm_estado_mascota`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `refugio`.`esm_estado_mascota` ;

CREATE TABLE IF NOT EXISTS `refugio`.`esm_estado_mascota` (
  `esm_id` INT NOT NULL COMMENT 'ID del estado de la mascota',
  `esm_estado` VARCHAR(20) NOT NULL COMMENT 'Estado en que se encuentra la mascota',
  PRIMARY KEY (`esm_id`))
ENGINE = InnoDB
COMMENT = 'Estado de las mascotas recogidas';


-- -----------------------------------------------------
-- Table `refugio`.`coj_color_ojos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `refugio`.`coj_color_ojos` ;

CREATE TABLE IF NOT EXISTS `refugio`.`coj_color_ojos` (
  `coj_id` INT NOT NULL COMMENT 'ID de color ojos',
  `coj_color_ojoscol` VARCHAR(20) NOT NULL COMMENT 'Color de ojos de la mascota',
  PRIMARY KEY (`coj_id`))
ENGINE = InnoDB
COMMENT = 'Color de ojos de las mascotas';


-- -----------------------------------------------------
-- Table `refugio`.`dep_departamento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `refugio`.`dep_departamento` ;

CREATE TABLE IF NOT EXISTS `refugio`.`dep_departamento` (
  `dep_id` INT NOT NULL COMMENT 'ID del departamento',
  `dep_nombre` VARCHAR(30) NOT NULL COMMENT 'Nombre del departamento',
  PRIMARY KEY (`dep_id`))
ENGINE = InnoDB
COMMENT = 'Departamento de donde pertenece el refugio';


-- -----------------------------------------------------
-- Table `refugio`.`mun_municipio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `refugio`.`mun_municipio` ;

CREATE TABLE IF NOT EXISTS `refugio`.`mun_municipio` (
  `mun_id` INT NOT NULL COMMENT 'ID del municipio',
  `mun_nombre` VARCHAR(60) NOT NULL COMMENT 'Nombre del municipio',
  `dep_mun_id` INT NOT NULL,
  PRIMARY KEY (`mun_id`, `dep_mun_id`),
  INDEX `fk_mun_municipio_dep_departamento1_idx` (`dep_mun_id` ASC),
  CONSTRAINT `fk_mun_municipio_dep_departamento1`
    FOREIGN KEY (`dep_mun_id`)
    REFERENCES `refugio`.`dep_departamento` (`dep_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Municipios en los que se encuentra el refugio';


-- -----------------------------------------------------
-- Table `refugio`.`rfg_refugio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `refugio`.`rfg_refugio` ;

CREATE TABLE IF NOT EXISTS `refugio`.`rfg_refugio` (
  `rfg_id` INT NOT NULL COMMENT 'ID del refugio',
  `rfg_nombre` VARCHAR(45) NOT NULL COMMENT 'Nombre del refugio',
  `rfg_descripcion` VARCHAR(200) NULL COMMENT 'Descripcion del refugio',
  `rfg_especialidad` VARCHAR(50) NULL COMMENT 'Tipo de especialidad del refugio',
  `rfg_ubicacion` VARCHAR(45) NOT NULL COMMENT 'Ubicacion fisica del refugio',
  `mun_rfg_id` INT NOT NULL,
  `mun_dep_id` INT NOT NULL,
  PRIMARY KEY (`rfg_id`, `mun_rfg_id`, `mun_dep_id`),
  INDEX `fk_rfg_refugio_mun_municipio1_idx` (`mun_rfg_id` ASC, `mun_dep_id` ASC),
  CONSTRAINT `fk_rfg_refugio_mun_municipio1`
    FOREIGN KEY (`mun_rfg_id` , `mun_dep_id`)
    REFERENCES `refugio`.`mun_municipio` (`mun_id` , `dep_mun_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Refugios registrados en el sitio';


-- -----------------------------------------------------
-- Table `refugio`.`gen_genero`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `refugio`.`gen_genero` ;

CREATE TABLE IF NOT EXISTS `refugio`.`gen_genero` (
  `gen_id` INT NOT NULL COMMENT 'ID del género',
  `gen_dato` CHAR(1) NOT NULL COMMENT 'Dato del género (F=Femenino, M=Masculino)',
  PRIMARY KEY (`gen_id`))
ENGINE = InnoDB
COMMENT = 'Géneros definidos dentro del sistema';


-- -----------------------------------------------------
-- Table `refugio`.`infm_informacion_mascota`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `refugio`.`infm_informacion_mascota` ;

CREATE TABLE IF NOT EXISTS `refugio`.`infm_informacion_mascota` (
  `infm_id` INT NOT NULL COMMENT 'ID de informacion mascota',
  `infm_foto` VARCHAR(100) NOT NULL COMMENT 'Foto de la mascota',
  `infm_nombre` VARCHAR(45) NOT NULL COMMENT 'Nombre de la mascota',
  `infm_descripcion` VARCHAR(150) NULL COMMENT 'Descripcion de la mascota',
  `infm_desparasitado` TINYINT(1) NOT NULL COMMENT 'Informacion de desparasitacion de la mascota',
  `infm_esterilizado` TINYINT(1) NOT NULL COMMENT 'Informacion de esterilizado de mascota',
  `infm_esm_id` INT NOT NULL,
  `infm_mas_id` INT NOT NULL,
  `infm_vac_id` INT NOT NULL,
  `infm_coj_id` INT NOT NULL,
  `infm_rfg_id` INT NOT NULL,
  `infm_gen_id` INT NOT NULL,
  PRIMARY KEY (`infm_id`, `infm_esm_id`, `infm_mas_id`, `infm_vac_id`, `infm_coj_id`, `infm_rfg_id`, `infm_gen_id`),
  INDEX `fk_infm_informacion_mascota_esm_estado_mascota1_idx` (`infm_esm_id` ASC),
  INDEX `fk_infm_informacion_mascota_mas_mascotas1_idx` (`infm_mas_id` ASC),
  INDEX `fk_infm_informacion_mascota_vac_vacunas1_idx` (`infm_vac_id` ASC),
  INDEX `fk_infm_informacion_mascota_coj_color_ojos1_idx` (`infm_coj_id` ASC),
  INDEX `fk_infm_informacion_mascota_rfg_refugio1_idx` (`infm_rfg_id` ASC),
  INDEX `fk_infm_informacion_mascota_gen_genero1_idx` (`infm_gen_id` ASC),
  CONSTRAINT `fk_infm_informacion_mascota_esm_estado_mascota1`
    FOREIGN KEY (`infm_esm_id`)
    REFERENCES `refugio`.`esm_estado_mascota` (`esm_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_infm_informacion_mascota_mas_mascotas1`
    FOREIGN KEY (`infm_mas_id`)
    REFERENCES `refugio`.`mas_mascotas` (`mas_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_infm_informacion_mascota_vac_vacunas1`
    FOREIGN KEY (`infm_vac_id`)
    REFERENCES `refugio`.`vac_vacunas` (`vac_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_infm_informacion_mascota_coj_color_ojos1`
    FOREIGN KEY (`infm_coj_id`)
    REFERENCES `refugio`.`coj_color_ojos` (`coj_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_infm_informacion_mascota_rfg_refugio1`
    FOREIGN KEY (`infm_rfg_id`)
    REFERENCES `refugio`.`rfg_refugio` (`rfg_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_infm_informacion_mascota_gen_genero1`
    FOREIGN KEY (`infm_gen_id`)
    REFERENCES `refugio`.`gen_genero` (`gen_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Datos de registro de la mascota';


-- -----------------------------------------------------
-- Table `refugio`.`ess_estado_solicitud`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `refugio`.`ess_estado_solicitud` ;

CREATE TABLE IF NOT EXISTS `refugio`.`ess_estado_solicitud` (
  `ess_id` INT NOT NULL,
  `ess_estado` VARCHAR(20) NOT NULL COMMENT 'Estado de la solicitud',
  `ess_descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`ess_id`))
ENGINE = InnoDB
COMMENT = 'Estado de la solicitud';


-- -----------------------------------------------------
-- Table `refugio`.`sol_solicitud`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `refugio`.`sol_solicitud` ;

CREATE TABLE IF NOT EXISTS `refugio`.`sol_solicitud` (
  `sol_id` INT NOT NULL,
  `sol_nombre1` VARCHAR(20) NOT NULL COMMENT '1er nombre del solicitante',
  `sol_nombre2` VARCHAR(20) NULL COMMENT '2o nombre del solicitante',
  `sol_apellido1` VARCHAR(20) NOT NULL COMMENT '1er apellido del solicitante',
  `gen_sol_id` INT NOT NULL,
  `sol_apellido2` VARCHAR(20) NOT NULL COMMENT '2o apellido del solicitante',
  `sol_direccion` VARCHAR(100) NULL COMMENT 'Direccion del solicitante',
  `sol_telfijo` CHAR(9) NULL COMMENT 'Telefono fijo del solicitante',
  `sol_telcel` CHAR(9) NULL COMMENT 'Telefono celular del solicitante',
  `mun_sol_id` INT NOT NULL,
  `dep_sol_id` INT NOT NULL,
  `sol_telofic` CHAR(9) NULL COMMENT 'Telefono oficina del solicitante',
  `sol_dui` CHAR(10) NOT NULL COMMENT 'DUI del solicitante',
  `sol_nit` CHAR(12) NOT NULL COMMENT 'NIT del solicitante',
  `sol_fnacimiento` VARCHAR(45) NULL COMMENT 'Fecha de nacimiento del solicitante',
  `sol_email` VARCHAR(45) NULL COMMENT 'Correo del solicitante',
  `ess_sol_id` INT NOT NULL,
  PRIMARY KEY (`sol_id`, `gen_sol_id`, `mun_sol_id`, `dep_sol_id`, `ess_sol_id`),
  INDEX `fk_sol_solicitud_gen_genero1_idx` (`gen_sol_id` ASC),
  INDEX `fk_sol_solicitud_mun_municipio1_idx` (`mun_sol_id` ASC, `dep_sol_id` ASC),
  INDEX `fk_sol_solicitud_ess_estado_solicitud1_idx` (`ess_sol_id` ASC),
  CONSTRAINT `fk_sol_solicitud_gen_genero1`
    FOREIGN KEY (`gen_sol_id`)
    REFERENCES `refugio`.`gen_genero` (`gen_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sol_solicitud_mun_municipio1`
    FOREIGN KEY (`mun_sol_id` , `dep_sol_id`)
    REFERENCES `refugio`.`mun_municipio` (`mun_id` , `dep_mun_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sol_solicitud_ess_estado_solicitud1`
    FOREIGN KEY (`ess_sol_id`)
    REFERENCES `refugio`.`ess_estado_solicitud` (`ess_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Solicitud de adopción para una mascota';


-- -----------------------------------------------------
-- Table `refugio`.`esp_especializaciones`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `refugio`.`esp_especializaciones` ;

CREATE TABLE IF NOT EXISTS `refugio`.`esp_especializaciones` (
  `esp_id` INT NOT NULL,
  `esp_nombre` VARCHAR(45) NOT NULL COMMENT 'Nombre de la especialización',
  `esp_descripcion` VARCHAR(100) NULL COMMENT 'Descripcion de la especialización',
  PRIMARY KEY (`esp_id`))
ENGINE = InnoDB
COMMENT = 'Especializacion de un empleado';


-- -----------------------------------------------------
-- Table `refugio`.`emp_empleado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `refugio`.`emp_empleado` ;

CREATE TABLE IF NOT EXISTS `refugio`.`emp_empleado` (
  `emp_id` INT NOT NULL,
  `emp_direccion` VARCHAR(100) NULL COMMENT 'Direccion del empleado',
  `emp_tel_trabajo` CHAR(9) NOT NULL COMMENT 'Telefono de oficina del empleado',
  `emp_email` VARCHAR(60) NOT NULL COMMENT 'Correo del empleado',
  `emp_dui` CHAR(9) NOT NULL COMMENT 'DUI del empleado',
  `emp_nit` CHAR(14) NOT NULL COMMENT 'NIT del empleado',
  `usr_emp_id` INT NOT NULL,
  `gen_emp_id` INT NOT NULL,
  `esp_emp_id` INT NOT NULL,
  PRIMARY KEY (`emp_id`, `usr_emp_id`, `gen_emp_id`, `esp_emp_id`),
  INDEX `fk_emp_empleado_usr_usuario1_idx` (`usr_emp_id` ASC),
  INDEX `fk_emp_empleado_gen_genero1_idx` (`gen_emp_id` ASC),
  INDEX `fk_emp_empleado_esp_especializaciones1_idx` (`esp_emp_id` ASC),
  CONSTRAINT `fk_emp_empleado_usr_usuario1`
    FOREIGN KEY (`usr_emp_id`)
    REFERENCES `refugio`.`usr_usuario` (`usr_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_emp_empleado_gen_genero1`
    FOREIGN KEY (`gen_emp_id`)
    REFERENCES `refugio`.`gen_genero` (`gen_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_emp_empleado_esp_especializaciones1`
    FOREIGN KEY (`esp_emp_id`)
    REFERENCES `refugio`.`esp_especializaciones` (`esp_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Datos de empleado del refugio';


-- -----------------------------------------------------
-- Table `refugio`.`doc_doctores`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `refugio`.`doc_doctores` ;

CREATE TABLE IF NOT EXISTS `refugio`.`doc_doctores` (
  `doc_id` INT NOT NULL,
  `emp_doc_id` INT NOT NULL,
  `doc_tipo` CHAR(7) NOT NULL COMMENT 'Tipo de doctor (externo/interno)',
  PRIMARY KEY (`doc_id`, `emp_doc_id`),
  INDEX `fk_doc_doctores_emp_empleado1_idx` (`emp_doc_id` ASC),
  CONSTRAINT `fk_doc_doctores_emp_empleado1`
    FOREIGN KEY (`emp_doc_id`)
    REFERENCES `refugio`.`emp_empleado` (`emp_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Datos de doctores';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
