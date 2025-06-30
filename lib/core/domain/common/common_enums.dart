import 'package:collection/collection.dart';

enum SortDirection {
  ASC,
  DESC,
}

enum LemonPronoun {
  he('He'),
  she('She'),
  they('They');

  final String pronoun;

  static LemonPronoun? fromString(String pronoun) {
    return LemonPronoun.values.firstWhereOrNull(
      (e) => e.pronoun == pronoun,
    );
  }

  const LemonPronoun(this.pronoun);
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
  // Handle for unknown case
  unknown('unknown', 'Unknown'),

  // Basic info
  displayName('display_name', 'Display name'),
  pronoun('pronoun', 'Pronoun'),
  tagline('tagline', 'Tagline'),
  description('description', 'Bio'),

// Personal info
  companyName('company_name', 'Organization'),
  jobTitle('job_title', 'Job Title'),
  industry('industry', 'Industry'),
  dateOfBirth('date_of_birth', 'Date of Birth'),
  educationTitle('education_title', 'Education'),
  newGender('new_gender', 'Gender'),
  ethnicity('ethnicity', 'Ethnicity'),

  // Socials
  handleTwitter('handle_twitter', 'Twitter'),
  handleLinkedin('handle_linkedin', 'Linkedin'),
  handleInstagram('handle_instagram', 'Instagram '),
  handleGithub('handle_github', 'Github'),
  handleCalendly('calendly_url', 'Calendly'),
  handleMirror('handle_mirror', 'Mirror'),
  handleFarcaster('handle_farcaster', 'Farcaster'),
  handleLens('handle_lens', 'Lens');

  final String fieldKey;
  final String label;

  const ProfileFieldKey(this.fieldKey, this.label);

  static String getFieldLabel(String fieldKey) {
    for (ProfileFieldKey field in ProfileFieldKey.values) {
      if (field.fieldKey == fieldKey) {
        return field.label;
      }
    }
    return fieldKey;
  }
}
