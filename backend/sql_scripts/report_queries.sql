-- 1. Get complete details for every location
SELECT L.*, 
       P.first_name AS general_manager_first_name, 
       P.last_name AS general_manager_last_name,
       (SELECT COUNT(*) FROM Personnel WHERE location_id = L.location_id) AS num_personnel,
       (SELECT COUNT(*) FROM ClubMembers CM 
        JOIN FamilyMembers FM ON CM.family_member_id = FM.family_member_id
        WHERE FM.location_id = L.location_id) AS num_club_members
FROM Locations L
LEFT JOIN Personnel P ON L.location_id = P.location_id AND P.role = 'Administrator'
ORDER BY L.province, L.city;

-- 2. Report: Family members with active club members
SELECT FM.first_name, FM.last_name, COUNT(CM.membership_number) AS num_active_members
FROM FamilyMembers FM
JOIN ClubMembers CM ON FM.family_member_id = CM.family_member_id
WHERE YEAR(CURDATE()) - YEAR(CM.dob) BETWEEN 11 AND 18
GROUP BY FM.family_member_id;

-- 3. Report: Personnel at a given location
SELECT first_name, last_name, dob, ssn, medicare_card_number, phone_number, address, city, province, postal_code, email, role, mandate
FROM Personnel
WHERE location_id = 1;

-- 4. List of all club members
SELECT CM.membership_number, CM.first_name, CM.last_name, 
       YEAR(CURDATE()) - YEAR(CM.dob) AS age, 
       L.name AS location_name,
       CASE WHEN YEAR(CURDATE()) - YEAR(CM.dob) BETWEEN 11 AND 18 THEN 'Active' ELSE 'Inactive' END AS status
FROM ClubMembers CM
JOIN FamilyMembers FM ON CM.family_member_id = FM.family_member_id
JOIN Locations L ON FM.location_id = L.location_id
ORDER BY L.name, age;
