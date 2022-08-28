SELECT 
		C.algorithm,
		SUM(case when C.Quarter = 1 then C.volume else 0 end) as transactions_Q1,
		sum(case when C.Quarter = 2 then C.volume else 0 end) as transactions_Q2,
		sum(case when C.Quarter = 3 then C.volume else 0 end) as transactions_Q3,
		sum(case when C.Quarter = 4 then C.volume else 0 end) as transactions_Q4
FROM
	(
		SELECT b.algorithm,a.volume,a.Quarter
		FROM 
			(
			SELECT coin_code,volume, DATEPART(qq,dt) as Quarter
			FROM transactions
			WHERE DATEPART(yy,dt) = 2020
			) A
		JOIN
			(
			SELECT algorithm,code
			FROM coins
			) B
		ON A.coin_code = B.code
	) C
GROUP BY C.algorithm;
