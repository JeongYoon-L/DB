# 상관분석에 이용될 데이터를 SELECT 해서 '지역별감염' 테이블 생성

create table 지역별감염 as
SELECT count(환자기본정보.환자ID) AS 확진자수, 환자기본정보.지역코드, 지역기본정보.초등학교수, 지역기본정보.유치원수, 지역기본정보.대학교수, 지역기본정보.학원비율, 지역기본정보.고령인구비율, 지역기본정보.독거노인비율, 지역기본정보.양로원수
FROM 환자기본정보 INNER JOIN 지역기본정보 ON (환자기본정보.지역코드 = 지역기본정보.지역코드)
where 환자기본정보.지역코드 not in (10000, 11000, 12000, 13000, 14000, 15000, 16000, 30000, 40000, 41000, 50000, 51000, 60000, 61000, 80000)
GROUP BY 환자기본정보.지역코드, 지역기본정보.초등학교수, 지역기본정보.유치원수, 지역기본정보.대학교수, 지역기본정보.학원비율, 지역기본정보.고령인구비율, 지역기본정보.독거노인비율, 지역기본정보.양로원수;

alter table 지역별감염 modify 확진자수 int;

alter table 지역별감염 add
primary key (지역코드);

alter table 지역별감염 add constraint 지역별감염_지역외래키
foreign key (지역코드) references 지역기본정보 (지역코드);

# 딥러닝에 이용될 데이터를 SELECT 해서 '딥러닝' 테이블 생성

create table 딥러닝 as
SELECT 위험라벨.위험라벨링값, 감염경로라벨.경로라벨링값 AS 감염경로라벨링, 환자기본정보.접촉자수, 
Count(환자이동경로.환자ID) AS 확진자동선개수, 지역별감염.대학교수, 지역별감염.양로원수, 지역별감염.유치원수, 환자기본정보.환자ID, 
환자기본정보.지역코드, 환자기본정보.감염유형, 지역별감염.확진자수 AS 확진자수, 지역별감염.초등학교수
FROM ((((지역별감염 INNER JOIN 
(환자이동경로 RIGHT JOIN 환자기본정보 ON 환자이동경로.환자ID = 환자기본정보.환자ID) 
ON (지역별감염.지역코드 = 환자기본정보.지역코드))
INNER JOIN 감염유형정보 ON 환자기본정보.감염유형 = 감염유형정보.소분류) 
INNER JOIN 감염경로라벨 ON 감염유형정보.대분류 = 감염경로라벨.종류)
INNER JOIN 위험라벨 ON 지역별감염.확진자수 = 위험라벨.확진자수)
GROUP BY 위험라벨.위험라벨링값, 감염경로라벨.경로라벨링값, 환자기본정보.접촉자수, 지역별감염.대학교수, 지역별감염.양로원수, 
지역별감염.초등학교수, 지역별감염.유치원수, 환자기본정보.지역코드, 환자기본정보.환자ID, 환자기본정보.감염유형, 지역별감염.확진자수
HAVING (((환자기본정보.감염유형)<>'해외유입'))
ORDER BY 환자기본정보.환자ID, 지역별감염.확진자수 DESC;

alter table 딥러닝 modify 확진자수 int;

alter table 딥러닝 add
primary key (환자ID);

alter table 딥러닝 add constraint 딥러닝_라벨외래키
foreign key (감염경로라벨링) references 감염경로라벨 (경로라벨링값);

alter table 딥러닝 add constraint 딥러닝_환자외래키
foreign key (환자ID) references 환자기본정보 (환자ID);

alter table 딥러닝 add constraint 딥러닝_지역별감염외래키
foreign key (지역코드) references 지역별감염 (지역코드);

alter table 딥러닝 add constraint 딥러닝_위험라벨외래키
foreign key (확진자수) references 위험라벨 (확진자수);