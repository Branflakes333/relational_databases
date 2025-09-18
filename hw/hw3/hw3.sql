-- 2.a 
SELECT  p_partkey AS "part key", 
        p_name AS "part name",
         '$' || p_retailprice AS "retail price"
FROM tpc_h.part
WHERE p_retailprice > 100;

-- 3.a
SELECT  part.p_name AS "part name", 
        supplier.s_name AS "supplier name"
FROM tpc_h.partsupp
JOIN tpc_h.part ON partsupp.ps_partkey = part.p_partkey
JOIN tpc_h.supplier ON partsupp.ps_suppkey = supplier.s_suppkey;


-- 3.b
SELECT  p_name AS "part name", 
        p_type AS "part type", 
        '$' || p_retailprice AS "retail price", 
        '$' || ps_supplycost AS "supply cost"
FROM tpc_h.part JOIN tpc_h.partsupp 
ON part.p_partkey = partsupp.ps_partkey
WHERE p_retailprice > ps_supplycost;

-- 4.a
SELECT  c_custkey AS "customer Key", 
        c_name AS "customer Name", 
        COUNT(o_orderkey) AS "orders"
FROM tpc_h.customer LEFT JOIN tpc_h.orders 
ON customer.c_custkey = orders.o_custkey
GROUP BY customer.c_custkey;

-- 4.b
SELECT n_name AS "nation"
FROM tpc_h.nation JOIN tpc_h.customer ON nation.n_nationkey = customer.c_nationkey
GROUP BY nation.n_nationkey
ORDER BY COUNT(customer.c_custkey) DESC
LIMIT 1;

-- 5.a
SELECT  n_name AS "nation", 
        '$' || SUM(o_totalprice) AS "total order value"
FROM tpc_h.nation LEFT JOIN tpc_h.customer ON nation.n_nationkey = customer.c_nationkey
JOIN tpc_h.orders ON customer.c_custkey = orders.o_custkey
GROUP BY n_name
ORDER BY SUM(o_totalprice) DESC;

-- 5.b

SELECT  COUNT(DISTINCT supplier.s_name) AS "number of suppliers", 
        p_name AS "part name"
FROM tpc_h.partsupp
JOIN tpc_h.part ON partsupp.ps_partkey = part.p_partkey
JOIN tpc_h.supplier ON partsupp.ps_suppkey = supplier.s_suppkey
GROUP BY p_name
ORDER BY COUNT(DISTINCT supplier.s_name) DESC
LIMIT 5

-- 5.c
SELECT  r_name AS "region", 
        '$' || SUM(o_totalprice) AS "total order value"
FROM tpc_h.region JOIN tpc_h.nation ON region.r_regionkey = nation.n_regionkey
JOIN tpc_h.customer ON nation.n_nationkey = customer.c_nationkey
JOIN tpc_h.orders ON customer.c_custkey = orders.o_custkey
GROUP BY r_name
ORDER BY SUM(o_totalprice) DESC;
