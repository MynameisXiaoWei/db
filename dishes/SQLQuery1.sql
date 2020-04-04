CREATE database task
go

CREATE TABLE dishes(
	dishid CHAR(10) PRIMARY KEY,		--菜品编号
	dishname VARCHAR(20) NOT NULL,		--菜品名
	dishprice DECIMAL(8,2) NOT NULL,	--价格
)
go

/**视图设计*/
/**查询菜品信息*/
CREATE VIEW v_dishes AS
	SELECT dishid 菜品编号,
		   dishname 菜品名,
		   dishprice 价格
	FROM dishes
go

/**增加菜品信息*/
INSERT INTO v_dishes(菜品编号,菜品名,价格) VALUES(6,'黄焖豆腐',25)
go

/**删除菜品信息*/
DELETE V_dishes WHERE 菜品编号 = 6 
go
	 
/**更新菜品信息*/
UPDATE v_dishes SET 价格 = 25 WHERE 菜品名 = '豆腐拌汤'
go

/**查询全部菜品*/

SELECT * FROM v_dishes
go

/**插入数据*/
insert into dishes values(1,'家常豆腐',17)
insert into dishes values(2,'麻辣豆腐',15)
insert into dishes values(3,'油炸豆腐',8)
insert into dishes values(4,'小葱拌豆腐',20)
insert into dishes values(5,'豆腐拌汤',10)
go

/**存储过程*/
/**新建存储过程*/
CREATE PROC P_dishes
	@dishid CHAR(10),
	@dishname VARCHAR(20),
	@dishprice DECIMAL(8,2)
	AS
	BEGIN
	--判断菜品信息是否重复录入
		IF EXISTS(SELECT * FROM v_dishes WHERE 菜品编号 = @dishid)
			PRINT '菜品编号重复,请重新录入!'
		ELSE
		IF (@dishname IS NULL) OR (@dishname = '') 
			PRINT '菜品名不能为空,请重新录入!'
		ELSE
		IF EXISTS(SELECT 菜品名 FROM v_dishes WHERE 菜品名 = @dishname)
			PRINT '菜品名重复,请重新录入!'
	ELSE
		BEGIN
			INSERT INTO v_dishes VALUES(@dishid,@dishname,@dishprice)
			PRINT '菜品信息添加成功!'
		END
	END
GO

--测试
EXEC P_dishes 1,'千叶豆腐',28
--测试2
EXEC P_dishes 8,'',77
--测试3
EXEC P_dishes 9,'家常豆腐',18
go



/**触发器*/
CREATE TRIGGER add_dishes_msg
ON dishes
FOR INSERT
AS
PRINT dbo.fun_printf()
GO

--测试
INSERT INTO v_dishes(菜品编号,菜品名,价格) VALUES(10,'麻婆豆腐',18)
go

CREATE FUNCTION dbo.fun_printf()
RETURNS VARCHAR(30)
AS
BEGIN
RETURN '你已向dishes表中插入了一条数据'
END