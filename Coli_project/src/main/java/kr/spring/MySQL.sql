SELECT * FROM member;

SELECT * FROM article;
select * from article_file;
SHOW TABLES;
select * from article_files;

select * from payment ;

delete from article ;
delete from article_file;
delete from comment ; 

DELETE FROM article a WHERE a.atc_id = 164 ;
DELETE FROM article_file a WHERE a.atc_id = 164 ;

ALTER TABLE member DROP COLUMN payment_id;

ALTER TABLE member
DROP FOREIGN KEY FK9rpivfsxaklo2gwh82gyms5vh;

DROP TABLE payment;