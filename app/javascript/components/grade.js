var getGradeStr = function (grade) {
    let gradestr = {
        0: "1年",
        1: "2年",
        2: "3年",
        3: "4年",
        4: "修士1年",
        5: "修士2年",
    };
    return gradestr[grade];
};
export default getGradeStr