-- Qno1. Identiy the single most critical skill gap causing the highest operational and revenue impact?

SELECT
    s.skill_name,
    AVG(es.required_proficiency - es.current_proficiency) AS average_skill_gap
FROM emp_skill
JOIN Skills s ON es.skill_id = s.skill_id
GROUP BY s.skill_name
ORDER BY average_skill_gap DESC
LIMIT 1;

commit;
