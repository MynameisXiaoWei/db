CREATE database task
go

CREATE TABLE dishes(
	dishid CHAR(10) PRIMARY KEY,		--��Ʒ���
	dishname VARCHAR(20) NOT NULL,		--��Ʒ��
	dishprice DECIMAL(8,2) NOT NULL,	--�۸�
)
go

/**��ͼ���*/
/**��ѯ��Ʒ��Ϣ*/
CREATE VIEW v_dishes AS
	SELECT dishid ��Ʒ���,
		   dishname ��Ʒ��,
		   dishprice �۸�
	FROM dishes
go

/**���Ӳ�Ʒ��Ϣ*/
INSERT INTO v_dishes(��Ʒ���,��Ʒ��,�۸�) VALUES(6,'���˶���',25)
go

/**ɾ����Ʒ��Ϣ*/
DELETE V_dishes WHERE ��Ʒ��� = 6 
go
	 
/**���²�Ʒ��Ϣ*/
UPDATE v_dishes SET �۸� = 25 WHERE ��Ʒ�� = '��������'
go

/**��ѯȫ����Ʒ*/

SELECT * FROM v_dishes
go

/**��������*/
insert into dishes values(1,'�ҳ�����',17)
insert into dishes values(2,'��������',15)
insert into dishes values(3,'��ը����',8)
insert into dishes values(4,'С�а趹��',20)
insert into dishes values(5,'��������',10)
go

/**�洢����*/
/**�½��洢����*/
CREATE PROC P_dishes
	@dishid CHAR(10),
	@dishname VARCHAR(20),
	@dishprice DECIMAL(8,2)
	AS
	BEGIN
	--�жϲ�Ʒ��Ϣ�Ƿ��ظ�¼��
		IF EXISTS(SELECT * FROM v_dishes WHERE ��Ʒ��� = @dishid)
			PRINT '��Ʒ����ظ�,������¼��!'
		ELSE
		IF (@dishname IS NULL) OR (@dishname = '') 
			PRINT '��Ʒ������Ϊ��,������¼��!'
		ELSE
		IF EXISTS(SELECT ��Ʒ�� FROM v_dishes WHERE ��Ʒ�� = @dishname)
			PRINT '��Ʒ���ظ�,������¼��!'
	ELSE
		BEGIN
			INSERT INTO v_dishes VALUES(@dishid,@dishname,@dishprice)
			PRINT '��Ʒ��Ϣ��ӳɹ�!'
		END
	END
GO

--����
EXEC P_dishes 1,'ǧҶ����',28
--����2
EXEC P_dishes 8,'',77
--����3
EXEC P_dishes 9,'�ҳ�����',18
go



/**������*/
CREATE TRIGGER add_dishes_msg
ON dishes
FOR INSERT
AS
PRINT dbo.fun_printf()
GO

--����
INSERT INTO v_dishes(��Ʒ���,��Ʒ��,�۸�) VALUES(10,'���Ŷ���',18)
go

CREATE FUNCTION dbo.fun_printf()
RETURNS VARCHAR(30)
AS
BEGIN
RETURN '������dishes���в�����һ������'
END