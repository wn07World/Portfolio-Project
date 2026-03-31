--selects the whole imported dataset in the DB
select * from Nashville_Housing_DataDB..Smartphone_Usage_Addiction_Analysis

--This shows us the average time that each gender spends daily on screen time
select gender, 
count(*) as count,
AVG(TRY_CAST(daily_screen_time_hours AS FLOAT)) as AVG_Scren_Time,
AVG(TRY_CAST(social_media_hours AS FLOAT)) as AVG_Social_media,
AVG(TRY_CAST(addicted_label AS INT)) as Addiction_Rate
from Nashville_Housing_DataDB..Smartphone_Usage_Addiction_Analysis
group by gender


--screentime addiction level
select addiction_level,
count(*) as count,
AVG(TRY_CAST(daily_screen_time_hours as float)) as AVG_Screen_Time,
MIN(TRY_CAST(daily_screen_time_hours as float)) as MIN_Screen_Time,
MAX(TRY_CAST(daily_screen_time_hours as float)) as MAX_Screen_Time,
AVG(TRY_CAST(addicted_label as int)) as Addiction_Percentage
from Nashville_Housing_DataDB..Smartphone_Usage_Addiction_Analysis
group by addiction_level
order by AVG_Screen_Time desc;

--avg number of notofications received a day
select gender, 
AVG(TRY_CAST(notifications_per_day AS int)) as AVG_Not_Per_day 
from Nashville_Housing_DataDB..Smartphone_Usage_Addiction_Analysis
group by gender

--calculates total % screen time dedicated to social media
select gender, 
max(social_media_hours)/avg(try_cast(daily_screen_time_hours as float))*100 as Dedicated_SMST
from Nashville_Housing_DataDB..Smartphone_Usage_Addiction_Analysis
group by gender

-- checks addiction level for Social Media, Gaming and Work study hours
select addiction_level,
AVG(TRY_CAST(social_media_hours as float)) as AVG_Social_Media,
AVG(TRY_Cast(gaming_hours as float)) as AVG_Gaming_Hrs,
AVG(TRY_Cast(work_study_hours as float)) as AVG_WS_Hrs
from Nashville_Housing_DataDB..Smartphone_Usage_Addiction_Analysis
group by addiction_level

--stress level impact
select stress_level,
AVG(TRY_CAST(daily_screen_time_hours as float)) as AVG_Screen_Time,
AVG(TRY_CAST(notifications_per_day as int)) as AVG_Notifications,
AVG(TRY_CAST(app_opens_per_day as int)) as AVG_App_Opens,
AVG(TRY_CAST(addicted_label as int)) as Addiction_Rate
from Nashville_Housing_DataDB..Smartphone_Usage_Addiction_Analysis
group by stress_level
order by Addiction_Rate

--academic impact by screen time
select academic_work_impact,
count(*) as count,
AVG(TRY_CAST(daily_screen_time_hours as float)) as AVG_Screen_Time,
AVG(TRY_CAST(work_study_hours as float)) as AVG_Study_Hours,
AVG(TRY_CAST(addicted_label as float)) as Addiction_Rate
from Nashville_Housing_DataDB..Smartphone_Usage_Addiction_Analysis
group by academic_work_impact








