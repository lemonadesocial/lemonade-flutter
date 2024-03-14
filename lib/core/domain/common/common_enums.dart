enum SortDirection {
  ASC,
  DESC,
}

enum LemonPronoun {
  he,
  she,
  they,
}

enum LemonIndustry {
  art('Arts'),
  social('Civic / Social'),
  consumer('Consumer Goods'),
  design('Design'),
  education('Education'),
  engineering('Engineering'),
  entertainment('Entertainment'),
  environment('Environment'),
  financial('Financial'),
  government('Government'),
  healthcare('Healthcare'),
  internationalAffairs('International Affairs'),
  manufacturing('Manufacturing'),
  marketing('Marketing and Advertising'),
  media('Media'),
  museum('Museums'),
  publicPolicy('Public Policy'),
  publicRelation('Public Relation and Communications'),
  realEstate('Real Estate'),
  sport('Sports and Gaming'),
  technology('Technology'),
  wellness('Wellness'),
  other('Other');

  final String industry;

  const LemonIndustry(this.industry);
}

enum LemonEthnicity {
  africanAmerican('African American'),
  alaskaNative('Alaska Native'),
  arab('Arab'),
  asian('Asian'),
  black('Black'),
  chinese('Han Chinese'),
  latino('Hispanic / Latino'),
  indian('Indian'),
  nativeAmerican('Native American'),
  nativeHawaiian('Native Hawaiian'),
  pacificIslander('Pacific Islander'),
  white('White'),
  other('Other');

  final String ethnicity;

  const LemonEthnicity(this.ethnicity);
}

enum LemonGender {
  female('Cis Female'),
  male('Cis Male'),
  fluid('Gender Fluid'),
  nonBinary('Non-Binary'),
  transgender('Transgender');

  final String newGender;

  const LemonGender(this.newGender);
}

enum ProfileFieldKey {
  displayName('display_name', 'Display name'),
  tagline('tagline', 'Tagline'),
  description('description', 'Description'),
  jobTitle('job_title', 'Job title'),
  companyName('company_name', 'Company name'),
  industry('industry', 'Industry'),
  educationTitle('education_title', 'Education'),
  newGender('new_gender', 'Gender'),
  ethnicity('ethnicity', 'Ethnicity'),
  dateOfBirth('date_of_birth', 'Date of birth'),
  handleGithub('handle_github', 'Github username');

  final String fieldKey;
  final String label;

  const ProfileFieldKey(this.fieldKey, this.label);
}
