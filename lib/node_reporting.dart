class Nodereport {
  late String EMP_FIRST_NAME;
  late String DEPT_NAME;
  late String DESIG_NAME;
  late String BRANCH_NAME;

  Nodereport(this.EMP_FIRST_NAME, this.DEPT_NAME, this.DESIG_NAME, this.BRANCH_NAME);

  Nodereport.fromJson(
      String EMP_FIRST_NAME, String DEPT_NAME, String DESIG_NAME, String BRANCH_NAME)
  {
    this.EMP_FIRST_NAME = EMP_FIRST_NAME;
    this.DEPT_NAME = DEPT_NAME;
    this.DESIG_NAME = DESIG_NAME;
    this.BRANCH_NAME = BRANCH_NAME;
  }
}