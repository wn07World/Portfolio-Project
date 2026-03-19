--shows us our imported dataset
select * from CallCenterDB..ConnectTel_CallCenterData

 --looking at best average customer satisfaction
SELECT Team,
AVG(TRY_CAST(CSATScore AS FLOAT)) AS AvgCSAT
FROM CallCenterDB..ConnectTel_CallCenterData
GROUP BY Team
ORDER BY AvgCSAT DESC;

--looks at which shift handles more calls and their duration
SELECT Shift,
AVG(TRY_CAST(CallsHandled AS FLOAT)) AS AvgCallsHandled,
AVG(TRY_CAST(AvgCallDuration AS FLOAT)) AS AvgCallDuration
FROM CallCenterDB..ConnectTel_CallCenterData
GROUP BY Shift
ORDER BY AvgCallsHandled DESC;

--team with highest cost per call
SELECT Team,
AVG(TRY_CAST(CostPerCall AS FLOAT)) AS AvgCost
FROM CallCenterDB..ConnectTel_CallCenterData
GROUP BY Team
ORDER BY AvgCost ASC;

--this allows us to see the min number of handledCalls
select Team, Sum(CallsHandled) as HandledCalls
from CallCenterDB..ConnectTel_CallCenterData
group by team
order by HandledCalls DESC;

-- creating view to store data for later visualization
CREATE VIEW ShiftPerformanceView AS
SELECT 
    Shift,
    AVG(TRY_CAST(CallsHandled AS FLOAT)) AS AvgCallsHandled,
    AVG(TRY_CAST(AvgCallDuration AS FLOAT)) AS AvgCallDuration
FROM CallCenterDB..ConnectTel_CallCenterData
GROUP BY Shift;

select * from ShiftPerformanceView;

