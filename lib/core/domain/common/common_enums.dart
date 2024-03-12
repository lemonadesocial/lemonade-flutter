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
  displayName('display_name'),
  tagline('tagline'),
  description('description'),
  jobTitle('job_title'),
  companyName('company_name'),
  industry('industry'),
  educationTitle('education_title'),
  newGender('new_gender'),
  ethnicity('ethnicity'),
  dateOfBirth('date_of_birth'),
  handleGithub('handle_github');

  final String fieldKey;

  const ProfileFieldKey(this.fieldKey);
}
