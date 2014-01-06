-- -------------------应付款总帐------------
CREATE  procedure P_SupplierPayTotal
(in BeginDatetime date,
in EndDatetime date,
in SupplierCode varchar(280),
in SupplierName varchar(280)
)
begin
declare Sql1 varchar(8000);
declare where_1 varchar(280);
declare where_2 varchar(280);
declare where_3 varchar(280);
set where_1  =' 1=1 '
set where_2  =' 1=1 '
set where_3  =' 1=1 '

set @sql1 = '
select a.SupplierCode,a.SupplierName ,
				IFNULL(PreAmount,0)+IFNULL(a.NeedPay,0)-IFNULL(a.AdvanceAmount,0)-IFNULL(e.Amount,0)-IFNULL(g.Amount,0)
				-(IFNULL(b.Amount,0)-IFNULL(h.Amount,0)-IFNULL(d.NowAmount,0)+IFNULL(v.Amount,0)-IFNULL(d.NowAmount,0)-IFNULL(s.Amount,0)
				-IFNULL(d.AdjustAmount,0)) as BeAmount,
				IFNULL(b.Amount,0) as HKAmount,				
				IFNULL(h.Amount,0)-IFNULL(v.Amount,0) as YFAmount ,
				IFNULL(d.NowAmount,0)+IFNULL(s.Amount,0) as FKAMount,
				IFNULL(d.AdjustAmount,0) as AdjustAMount,
				IFNULL(PreAmount,0)+IFNULL(a.NeedPay,0)-IFNULL(a.AdvanceAmount,0)-IFNULL(e.Amount,0)-IFNULL(g.Amount,0) as EnAmount				
from JBSupplier a 
left join -- -------------本期
(-- 货款
select SupplierCode,sum(IFNULL(Amount,0)) as Amount
from (
		select  SupplierCode,(case InOutTypeNo when 42 then IFNULL(ckAmount,0) else Ifnull(-ckAmount,0) end )  as Amount
		from CKJHCheck a 
		left join Employee b on b.usr_no = a.EmpCode
		left join partment	c on c.DeptCode = a.DeptCode
		where  IFNULL(CheckFlag,0) = 1
	) a  group by SupplierCode
) b on a.SupplierCode = b.SupplierCode
left join 
(-- ---付款金额
		select SupplierCode,sum(IFNULL(d.NowCollated,0)) as NowAmount,sum(IFNULL(d.Adjust,0)) as AdjustAmount
			from  JHPay a
			left join  JHPayDetail d on d.OrderCode = a.OrderCode 
			left join Employee b on b.usr_no = a.EmpCode
			left join partment	c on c.DeptCode = a.DeptCode
			where    IfNull(CheckFlag,0) = 1  and PayType in (1)
			group by SupplierCode
) d on d.SupplierCode = a.SupplierCode
left Join 
(-- ---预付款金额
		select SupplierCode,sum(IFNULL(Amount,0)) as Amount
			from  JHPay a
			left join Employee	b on b.usr_no = a.empCode
			left join partment	c on c.DeptCode = a.DeptCode
			where    IFNULL(CheckFlag,0) = 1 -- and PayType in (2) AND ' +  where_1+ '
			group by SupplierCode
) h on h.SupplierCode = a.SupplierCode
left join 
(-- ---直接付款金额
		select SupplierCode,sum(IFNULL(Amount,0)) as Amount
			from  JHPay a
			left join Employee		b on b.usr_No = a.empCode
			left join partment	c on c.DeptCode = a.DeptCode
			where    IFNULL(CheckFlag,0) = 1 -- and PayType in (4) AND ' + where_1+ '  
			group by SupplierCode
) s on s.SupplierCode = a.SupplierCode
left join
(-- ---预付冲应付
		select SupplierCode,sum(IFNULL(d.NowCollated,0)) as NowAmount,sum(IFNULL(d.Adjust,0)) as AdjustAmount,sum(IFNULL(d.Amount,0)) as Amount
			from  JHPay a
			left join  JHPayDetail d on d.OrderCode = a.OrderCode 
			left join Employee	b on b.usr_No = a.EmpCode
			left join partment	c on c.DeptCode = a.DeptCode
			where    IFNULL(CheckFlag,0) = 1 -- and PayType in (3) AND  ' + where_1 +' 
			group by SupplierCode
) v on v.SupplierCode = a.SupplierCode


left join -- ---期末到当前
(
select SupplierCode,sum(IFNULL(Amount,0)) as Amount
from (
		select  SupplierCode,(case InOutTypeNo when 42  then IFNULL(ckAmount,0) else IFNULL(-ckAmount,0) end )  as Amount
		from  CKJHCheck a 
		left join Employee		b on b.usr_no = a.EmpCode
		left join partment	c on c.DeptCode = a.DeptCode
		where  IFNULL(CheckFlag,0) = 1  AND  '+where_3 +' 
	) a  group by SupplierCode
) e on a.SupplierCode = e.SupplierCode
left join 
(
		select SupplierCode,sum(IFNULL(Amount,0)) as Amount
		from JHPay   a 
		left join Employee		b on b.usr_No = a.EmpCode
		left join partment	c on c.DeptCode = a.DeptCode
			where   PayType in (1,2,3,4)  and IFNULL(CheckFlag,0) = 1  AND '+where_3 +'
			group by SupplierCode
) g on g.SupplierCode = a.SupplierCode
 where ' + where_2 +'''
 '
 end