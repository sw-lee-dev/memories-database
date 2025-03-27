use memories;

SELECT * FROM user;
SELECT * FROM diary;
SELECT * FROM memory_test;
SELECT * FROM concentration_test;
SELECT * FROM comment;
SELECT * FROM empathy;

-- -----------------------------------------------------
-- Table `memories`.`empathy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `memories`.`empathy` (
  `user_id` VARCHAR(20) NOT NULL COMMENT '공감한 사용자 아이디',
  `diary_number` INT NOT NULL COMMENT '공감된 일기 번호',
  PRIMARY KEY (`user_id`, `diary_number`),
  INDEX `fk_user_has_diary_diary1_idx` (`diary_number` ASC) VISIBLE,
  INDEX `fk_user_has_diary_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_has_diary_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `memories`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_diary_diary1`
    FOREIGN KEY (`diary_number`)
    REFERENCES `memories`.`diary` (`diary_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '공감 관계 테이블';


-- -----------------------------------------------------
-- Table `memories`.`comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `memories`.`comment` (
  `comment_number` INT NOT NULL AUTO_INCREMENT COMMENT '댓글 번호',
  `diary_number` INT NOT NULL COMMENT '댓글이 작성된 일기 번호',
  `user_id` VARCHAR(20) NOT NULL COMMENT '댓글을 작성한 사용자 아이디',
  `write_date` VARCHAR(20) NOT NULL COMMENT '댓글 작성일',
  `content` TEXT NOT NULL COMMENT '댓글 내용',
  INDEX `fk_diary_has_user_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_diary_has_user_diary1_idx` (`diary_number` ASC) VISIBLE,
  PRIMARY KEY (`comment_number`),
  UNIQUE INDEX `comment_number_UNIQUE` (`comment_number` ASC) VISIBLE,
  CONSTRAINT `fk_diary_has_user_diary1`
    FOREIGN KEY (`diary_number`)
    REFERENCES `memories`.`diary` (`diary_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_diary_has_user_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `memories`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '댓글 관계 테이블';