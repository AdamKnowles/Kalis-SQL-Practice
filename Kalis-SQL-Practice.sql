


--1. show all patients that are currently discharged with the last name of "knowles"
SELECT *
FROM kalisAPI_patient p
WHERE deleted NOTNULL and last_name is "knowles" 


--2. show all vital sign and assessment id's related to each patient 
SELECT first_name,last_name,a.id AS "Assessment Id", v.id AS "Vital Sign Id", deleted
FROM kalisAPI_patient p
JOIN kalisAPI_assessment a ON a.patient_id = p.id 
JOIN kalisAPI_vitalsigns v ON v.patient_id = p.id
WHERE deleted ISNULL


--3. show basic assessment information for each admitted patient that has an assessment
SELECT p.id AS "Patient Id",last_name, first_name,  a.id AS "Assessment Id", npo, heart_sounds, breath_sounds
FROM kalisAPI_assessment AS a
Join kalisAPI_patient As p On p.id = a.patient_id
JOIN kalisAPI_npo AS n on n.id = a.npo_id
JOIN kalisAPI_breathsounds AS b on b.id = a.breath_sounds_id
JOIN kalisAPI_heartsounds AS h on h.id = a.heart_sounds_id
WHERE deleted ISNULL 
Order By last_name ASC

--4. show the patients that are assigned to a user(nurse,doctor etc)
SELECT kalisAPI_patient.last_name, kalisAPI_patient.first_name, user_id, username
FROM kalisAPI_mypatients
JOIN kalisAPI_patient ON kalisAPI_patient.id = kalisAPI_mypatients.patient_id		
join auth_user on auth_user.id = kalisAPI_mypatients.user_id

--5. show all patients not assigned to a user
SELECT kalisAPI_patient.last_name, kalisAPI_patient.first_name, user_id, username
FROM kalisAPI_patient
LEFT JOIN kalisAPI_mypatients ON kalisAPI_mypatients.patient_id = kalisAPI_patient.id		
Left join auth_user on auth_user.id = kalisAPI_mypatients.user_id
WHERE user_id ISNULL


--6. sort vital signs by patient, count number of sets of vital signs on each patient that is admitted
SELECT last_name, first_name,p.id, COUNT(v.id)
FROM kalisAPI_patient p
JOIN kalisAPI_vitalsigns v ON v.patient_id = p.id
WHERE deleted ISNULL
GROUP BY p.id


--7. show all vital signs with an abnormal heart rate, under 60
SELECT last_name, first_name,p.id, heart_rate
FROM kalisAPI_patient p
JOIN kalisAPI_vitalsigns v ON v.patient_id = p.id
WHERE deleted ISNULL AND heart_rate < 60

--8. count number of total discharged patients
SELECT COUNT(p.id) AS "Total patients discharged"
FROM kalisAPI_patient p
WHERE deleted NOTNULL 


--9. show all admitted patients that are alert and oriented
SELECT last_name, first_name, mental_status_id, mental_status
FROM kalisAPI_assessment a
JOIN kalisAPI_patient p ON p.id = a.patient_id
JOIN kalisAPI_mentalstatus m ON m.id = a.mental_status_id
WHERE m.mental_status = "Alert and Oriented " AND deleted ISNULL

--10. show all admitted patients that are disorinted
SELECT last_name, first_name, mental_status_id, mental_status
FROM kalisAPI_assessment a
JOIN kalisAPI_patient p ON p.id = a.patient_id
JOIN kalisAPI_mentalstatus m ON m.id = a.mental_status_id
WHERE m.mental_status = "Disoriented" AND deleted ISNULL

--11. show all admitted patients that do not have an assessment on file
SELECT *
FROM kalisAPI_patient p
LEFT JOIN kalisAPI_assessment a ON a.patient_id = p.id
WHERE a.id ISNULL








