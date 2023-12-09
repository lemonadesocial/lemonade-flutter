class Input$ConfigFilter {
  factory Input$ConfigFilter({
    String? $_id_eq,
    bool? $_id_exists,
    String? $_id_gt,
    String? $_id_gte,
    List<String>? $_id_in,
    String? $_id_lt,
    String? $_id_lte,
    String? createdAt_eq,
    bool? createdAt_exists,
    String? createdAt_gt,
    String? createdAt_gte,
    List<String>? createdAt_in,
    String? createdAt_lt,
    String? createdAt_lte,
    String? updatedAt_eq,
    bool? updatedAt_exists,
    String? updatedAt_gt,
    String? updatedAt_gte,
    List<String>? updatedAt_in,
    String? updatedAt_lt,
    String? updatedAt_lte,
    String? avatar_eq,
    bool? avatar_exists,
    String? avatar_gt,
    String? avatar_gte,
    List<String>? avatar_in,
    String? avatar_lt,
    String? avatar_lte,
    String? backstory_eq,
    bool? backstory_exists,
    String? backstory_gt,
    String? backstory_gte,
    List<String>? backstory_in,
    String? backstory_lt,
    String? backstory_lte,
    String? description_eq,
    bool? description_exists,
    String? description_gt,
    String? description_gte,
    List<String>? description_in,
    String? description_lt,
    String? description_lte,
    Map<String, dynamic>? filter_eq,
    bool? filter_exists,
    Map<String, dynamic>? filter_gt,
    Map<String, dynamic>? filter_gte,
    List<Map<String, dynamic>>? filter_in,
    Map<String, dynamic>? filter_lt,
    Map<String, dynamic>? filter_lte,
    bool? isPublic_eq,
    bool? isPublic_exists,
    bool? isPublic_gt,
    bool? isPublic_gte,
    List<bool>? isPublic_in,
    bool? isPublic_lt,
    bool? isPublic_lte,
    String? job_eq,
    bool? job_exists,
    String? job_gt,
    String? job_gte,
    List<String>? job_in,
    String? job_lt,
    String? job_lte,
    String? modelName_eq,
    bool? modelName_exists,
    String? modelName_gt,
    String? modelName_gte,
    List<String>? modelName_in,
    String? modelName_lt,
    String? modelName_lte,
    String? name_eq,
    bool? name_exists,
    String? name_gt,
    String? name_gte,
    List<String>? name_in,
    String? name_lt,
    String? name_lte,
    String? openaiApiKey_eq,
    bool? openaiApiKey_exists,
    String? openaiApiKey_gt,
    String? openaiApiKey_gte,
    List<String>? openaiApiKey_in,
    String? openaiApiKey_lt,
    String? openaiApiKey_lte,
    String? systemMessage_eq,
    bool? systemMessage_exists,
    String? systemMessage_gt,
    String? systemMessage_gte,
    List<String>? systemMessage_in,
    String? systemMessage_lt,
    String? systemMessage_lte,
    double? temperature_eq,
    bool? temperature_exists,
    double? temperature_gt,
    double? temperature_gte,
    List<double>? temperature_in,
    double? temperature_lt,
    double? temperature_lte,
    double? topP_eq,
    bool? topP_exists,
    double? topP_gt,
    double? topP_gte,
    List<double>? topP_in,
    double? topP_lt,
    double? topP_lte,
    String? user_eq,
    bool? user_exists,
    String? user_gt,
    String? user_gte,
    List<String>? user_in,
    String? user_lt,
    String? user_lte,
    String? welcomeMessage_eq,
    bool? welcomeMessage_exists,
    String? welcomeMessage_gt,
    String? welcomeMessage_gte,
    List<String>? welcomeMessage_in,
    String? welcomeMessage_lt,
    String? welcomeMessage_lte,
    Map<String, dynamic>? welcomeMetadata_eq,
    bool? welcomeMetadata_exists,
    Map<String, dynamic>? welcomeMetadata_gt,
    Map<String, dynamic>? welcomeMetadata_gte,
    List<Map<String, dynamic>>? welcomeMetadata_in,
    Map<String, dynamic>? welcomeMetadata_lt,
    Map<String, dynamic>? welcomeMetadata_lte,
  }) =>
      Input$ConfigFilter._({
        if ($_id_eq != null) r'_id_eq': $_id_eq,
        if ($_id_exists != null) r'_id_exists': $_id_exists,
        if ($_id_gt != null) r'_id_gt': $_id_gt,
        if ($_id_gte != null) r'_id_gte': $_id_gte,
        if ($_id_in != null) r'_id_in': $_id_in,
        if ($_id_lt != null) r'_id_lt': $_id_lt,
        if ($_id_lte != null) r'_id_lte': $_id_lte,
        if (createdAt_eq != null) r'createdAt_eq': createdAt_eq,
        if (createdAt_exists != null) r'createdAt_exists': createdAt_exists,
        if (createdAt_gt != null) r'createdAt_gt': createdAt_gt,
        if (createdAt_gte != null) r'createdAt_gte': createdAt_gte,
        if (createdAt_in != null) r'createdAt_in': createdAt_in,
        if (createdAt_lt != null) r'createdAt_lt': createdAt_lt,
        if (createdAt_lte != null) r'createdAt_lte': createdAt_lte,
        if (updatedAt_eq != null) r'updatedAt_eq': updatedAt_eq,
        if (updatedAt_exists != null) r'updatedAt_exists': updatedAt_exists,
        if (updatedAt_gt != null) r'updatedAt_gt': updatedAt_gt,
        if (updatedAt_gte != null) r'updatedAt_gte': updatedAt_gte,
        if (updatedAt_in != null) r'updatedAt_in': updatedAt_in,
        if (updatedAt_lt != null) r'updatedAt_lt': updatedAt_lt,
        if (updatedAt_lte != null) r'updatedAt_lte': updatedAt_lte,
        if (avatar_eq != null) r'avatar_eq': avatar_eq,
        if (avatar_exists != null) r'avatar_exists': avatar_exists,
        if (avatar_gt != null) r'avatar_gt': avatar_gt,
        if (avatar_gte != null) r'avatar_gte': avatar_gte,
        if (avatar_in != null) r'avatar_in': avatar_in,
        if (avatar_lt != null) r'avatar_lt': avatar_lt,
        if (avatar_lte != null) r'avatar_lte': avatar_lte,
        if (backstory_eq != null) r'backstory_eq': backstory_eq,
        if (backstory_exists != null) r'backstory_exists': backstory_exists,
        if (backstory_gt != null) r'backstory_gt': backstory_gt,
        if (backstory_gte != null) r'backstory_gte': backstory_gte,
        if (backstory_in != null) r'backstory_in': backstory_in,
        if (backstory_lt != null) r'backstory_lt': backstory_lt,
        if (backstory_lte != null) r'backstory_lte': backstory_lte,
        if (description_eq != null) r'description_eq': description_eq,
        if (description_exists != null)
          r'description_exists': description_exists,
        if (description_gt != null) r'description_gt': description_gt,
        if (description_gte != null) r'description_gte': description_gte,
        if (description_in != null) r'description_in': description_in,
        if (description_lt != null) r'description_lt': description_lt,
        if (description_lte != null) r'description_lte': description_lte,
        if (filter_eq != null) r'filter_eq': filter_eq,
        if (filter_exists != null) r'filter_exists': filter_exists,
        if (filter_gt != null) r'filter_gt': filter_gt,
        if (filter_gte != null) r'filter_gte': filter_gte,
        if (filter_in != null) r'filter_in': filter_in,
        if (filter_lt != null) r'filter_lt': filter_lt,
        if (filter_lte != null) r'filter_lte': filter_lte,
        if (isPublic_eq != null) r'isPublic_eq': isPublic_eq,
        if (isPublic_exists != null) r'isPublic_exists': isPublic_exists,
        if (isPublic_gt != null) r'isPublic_gt': isPublic_gt,
        if (isPublic_gte != null) r'isPublic_gte': isPublic_gte,
        if (isPublic_in != null) r'isPublic_in': isPublic_in,
        if (isPublic_lt != null) r'isPublic_lt': isPublic_lt,
        if (isPublic_lte != null) r'isPublic_lte': isPublic_lte,
        if (job_eq != null) r'job_eq': job_eq,
        if (job_exists != null) r'job_exists': job_exists,
        if (job_gt != null) r'job_gt': job_gt,
        if (job_gte != null) r'job_gte': job_gte,
        if (job_in != null) r'job_in': job_in,
        if (job_lt != null) r'job_lt': job_lt,
        if (job_lte != null) r'job_lte': job_lte,
        if (modelName_eq != null) r'modelName_eq': modelName_eq,
        if (modelName_exists != null) r'modelName_exists': modelName_exists,
        if (modelName_gt != null) r'modelName_gt': modelName_gt,
        if (modelName_gte != null) r'modelName_gte': modelName_gte,
        if (modelName_in != null) r'modelName_in': modelName_in,
        if (modelName_lt != null) r'modelName_lt': modelName_lt,
        if (modelName_lte != null) r'modelName_lte': modelName_lte,
        if (name_eq != null) r'name_eq': name_eq,
        if (name_exists != null) r'name_exists': name_exists,
        if (name_gt != null) r'name_gt': name_gt,
        if (name_gte != null) r'name_gte': name_gte,
        if (name_in != null) r'name_in': name_in,
        if (name_lt != null) r'name_lt': name_lt,
        if (name_lte != null) r'name_lte': name_lte,
        if (openaiApiKey_eq != null) r'openaiApiKey_eq': openaiApiKey_eq,
        if (openaiApiKey_exists != null)
          r'openaiApiKey_exists': openaiApiKey_exists,
        if (openaiApiKey_gt != null) r'openaiApiKey_gt': openaiApiKey_gt,
        if (openaiApiKey_gte != null) r'openaiApiKey_gte': openaiApiKey_gte,
        if (openaiApiKey_in != null) r'openaiApiKey_in': openaiApiKey_in,
        if (openaiApiKey_lt != null) r'openaiApiKey_lt': openaiApiKey_lt,
        if (openaiApiKey_lte != null) r'openaiApiKey_lte': openaiApiKey_lte,
        if (systemMessage_eq != null) r'systemMessage_eq': systemMessage_eq,
        if (systemMessage_exists != null)
          r'systemMessage_exists': systemMessage_exists,
        if (systemMessage_gt != null) r'systemMessage_gt': systemMessage_gt,
        if (systemMessage_gte != null) r'systemMessage_gte': systemMessage_gte,
        if (systemMessage_in != null) r'systemMessage_in': systemMessage_in,
        if (systemMessage_lt != null) r'systemMessage_lt': systemMessage_lt,
        if (systemMessage_lte != null) r'systemMessage_lte': systemMessage_lte,
        if (temperature_eq != null) r'temperature_eq': temperature_eq,
        if (temperature_exists != null)
          r'temperature_exists': temperature_exists,
        if (temperature_gt != null) r'temperature_gt': temperature_gt,
        if (temperature_gte != null) r'temperature_gte': temperature_gte,
        if (temperature_in != null) r'temperature_in': temperature_in,
        if (temperature_lt != null) r'temperature_lt': temperature_lt,
        if (temperature_lte != null) r'temperature_lte': temperature_lte,
        if (topP_eq != null) r'topP_eq': topP_eq,
        if (topP_exists != null) r'topP_exists': topP_exists,
        if (topP_gt != null) r'topP_gt': topP_gt,
        if (topP_gte != null) r'topP_gte': topP_gte,
        if (topP_in != null) r'topP_in': topP_in,
        if (topP_lt != null) r'topP_lt': topP_lt,
        if (topP_lte != null) r'topP_lte': topP_lte,
        if (user_eq != null) r'user_eq': user_eq,
        if (user_exists != null) r'user_exists': user_exists,
        if (user_gt != null) r'user_gt': user_gt,
        if (user_gte != null) r'user_gte': user_gte,
        if (user_in != null) r'user_in': user_in,
        if (user_lt != null) r'user_lt': user_lt,
        if (user_lte != null) r'user_lte': user_lte,
        if (welcomeMessage_eq != null) r'welcomeMessage_eq': welcomeMessage_eq,
        if (welcomeMessage_exists != null)
          r'welcomeMessage_exists': welcomeMessage_exists,
        if (welcomeMessage_gt != null) r'welcomeMessage_gt': welcomeMessage_gt,
        if (welcomeMessage_gte != null)
          r'welcomeMessage_gte': welcomeMessage_gte,
        if (welcomeMessage_in != null) r'welcomeMessage_in': welcomeMessage_in,
        if (welcomeMessage_lt != null) r'welcomeMessage_lt': welcomeMessage_lt,
        if (welcomeMessage_lte != null)
          r'welcomeMessage_lte': welcomeMessage_lte,
        if (welcomeMetadata_eq != null)
          r'welcomeMetadata_eq': welcomeMetadata_eq,
        if (welcomeMetadata_exists != null)
          r'welcomeMetadata_exists': welcomeMetadata_exists,
        if (welcomeMetadata_gt != null)
          r'welcomeMetadata_gt': welcomeMetadata_gt,
        if (welcomeMetadata_gte != null)
          r'welcomeMetadata_gte': welcomeMetadata_gte,
        if (welcomeMetadata_in != null)
          r'welcomeMetadata_in': welcomeMetadata_in,
        if (welcomeMetadata_lt != null)
          r'welcomeMetadata_lt': welcomeMetadata_lt,
        if (welcomeMetadata_lte != null)
          r'welcomeMetadata_lte': welcomeMetadata_lte,
      });

  Input$ConfigFilter._(this._$data);

  factory Input$ConfigFilter.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    if (data.containsKey('_id_eq')) {
      final l$$_id_eq = data['_id_eq'];
      result$data['_id_eq'] = (l$$_id_eq as String?);
    }
    if (data.containsKey('_id_exists')) {
      final l$$_id_exists = data['_id_exists'];
      result$data['_id_exists'] = (l$$_id_exists as bool?);
    }
    if (data.containsKey('_id_gt')) {
      final l$$_id_gt = data['_id_gt'];
      result$data['_id_gt'] = (l$$_id_gt as String?);
    }
    if (data.containsKey('_id_gte')) {
      final l$$_id_gte = data['_id_gte'];
      result$data['_id_gte'] = (l$$_id_gte as String?);
    }
    if (data.containsKey('_id_in')) {
      final l$$_id_in = data['_id_in'];
      result$data['_id_in'] =
          (l$$_id_in as List<dynamic>?)?.map((e) => (e as String)).toList();
    }
    if (data.containsKey('_id_lt')) {
      final l$$_id_lt = data['_id_lt'];
      result$data['_id_lt'] = (l$$_id_lt as String?);
    }
    if (data.containsKey('_id_lte')) {
      final l$$_id_lte = data['_id_lte'];
      result$data['_id_lte'] = (l$$_id_lte as String?);
    }
    if (data.containsKey('createdAt_eq')) {
      final l$createdAt_eq = data['createdAt_eq'];
      result$data['createdAt_eq'] = (l$createdAt_eq as String?);
    }
    if (data.containsKey('createdAt_exists')) {
      final l$createdAt_exists = data['createdAt_exists'];
      result$data['createdAt_exists'] = (l$createdAt_exists as bool?);
    }
    if (data.containsKey('createdAt_gt')) {
      final l$createdAt_gt = data['createdAt_gt'];
      result$data['createdAt_gt'] = (l$createdAt_gt as String?);
    }
    if (data.containsKey('createdAt_gte')) {
      final l$createdAt_gte = data['createdAt_gte'];
      result$data['createdAt_gte'] = (l$createdAt_gte as String?);
    }
    if (data.containsKey('createdAt_in')) {
      final l$createdAt_in = data['createdAt_in'];
      result$data['createdAt_in'] = (l$createdAt_in as List<dynamic>?)
          ?.map((e) => (e as String))
          .toList();
    }
    if (data.containsKey('createdAt_lt')) {
      final l$createdAt_lt = data['createdAt_lt'];
      result$data['createdAt_lt'] = (l$createdAt_lt as String?);
    }
    if (data.containsKey('createdAt_lte')) {
      final l$createdAt_lte = data['createdAt_lte'];
      result$data['createdAt_lte'] = (l$createdAt_lte as String?);
    }
    if (data.containsKey('updatedAt_eq')) {
      final l$updatedAt_eq = data['updatedAt_eq'];
      result$data['updatedAt_eq'] = (l$updatedAt_eq as String?);
    }
    if (data.containsKey('updatedAt_exists')) {
      final l$updatedAt_exists = data['updatedAt_exists'];
      result$data['updatedAt_exists'] = (l$updatedAt_exists as bool?);
    }
    if (data.containsKey('updatedAt_gt')) {
      final l$updatedAt_gt = data['updatedAt_gt'];
      result$data['updatedAt_gt'] = (l$updatedAt_gt as String?);
    }
    if (data.containsKey('updatedAt_gte')) {
      final l$updatedAt_gte = data['updatedAt_gte'];
      result$data['updatedAt_gte'] = (l$updatedAt_gte as String?);
    }
    if (data.containsKey('updatedAt_in')) {
      final l$updatedAt_in = data['updatedAt_in'];
      result$data['updatedAt_in'] = (l$updatedAt_in as List<dynamic>?)
          ?.map((e) => (e as String))
          .toList();
    }
    if (data.containsKey('updatedAt_lt')) {
      final l$updatedAt_lt = data['updatedAt_lt'];
      result$data['updatedAt_lt'] = (l$updatedAt_lt as String?);
    }
    if (data.containsKey('updatedAt_lte')) {
      final l$updatedAt_lte = data['updatedAt_lte'];
      result$data['updatedAt_lte'] = (l$updatedAt_lte as String?);
    }
    if (data.containsKey('avatar_eq')) {
      final l$avatar_eq = data['avatar_eq'];
      result$data['avatar_eq'] = (l$avatar_eq as String?);
    }
    if (data.containsKey('avatar_exists')) {
      final l$avatar_exists = data['avatar_exists'];
      result$data['avatar_exists'] = (l$avatar_exists as bool?);
    }
    if (data.containsKey('avatar_gt')) {
      final l$avatar_gt = data['avatar_gt'];
      result$data['avatar_gt'] = (l$avatar_gt as String?);
    }
    if (data.containsKey('avatar_gte')) {
      final l$avatar_gte = data['avatar_gte'];
      result$data['avatar_gte'] = (l$avatar_gte as String?);
    }
    if (data.containsKey('avatar_in')) {
      final l$avatar_in = data['avatar_in'];
      result$data['avatar_in'] =
          (l$avatar_in as List<dynamic>?)?.map((e) => (e as String)).toList();
    }
    if (data.containsKey('avatar_lt')) {
      final l$avatar_lt = data['avatar_lt'];
      result$data['avatar_lt'] = (l$avatar_lt as String?);
    }
    if (data.containsKey('avatar_lte')) {
      final l$avatar_lte = data['avatar_lte'];
      result$data['avatar_lte'] = (l$avatar_lte as String?);
    }
    if (data.containsKey('backstory_eq')) {
      final l$backstory_eq = data['backstory_eq'];
      result$data['backstory_eq'] = (l$backstory_eq as String?);
    }
    if (data.containsKey('backstory_exists')) {
      final l$backstory_exists = data['backstory_exists'];
      result$data['backstory_exists'] = (l$backstory_exists as bool?);
    }
    if (data.containsKey('backstory_gt')) {
      final l$backstory_gt = data['backstory_gt'];
      result$data['backstory_gt'] = (l$backstory_gt as String?);
    }
    if (data.containsKey('backstory_gte')) {
      final l$backstory_gte = data['backstory_gte'];
      result$data['backstory_gte'] = (l$backstory_gte as String?);
    }
    if (data.containsKey('backstory_in')) {
      final l$backstory_in = data['backstory_in'];
      result$data['backstory_in'] = (l$backstory_in as List<dynamic>?)
          ?.map((e) => (e as String))
          .toList();
    }
    if (data.containsKey('backstory_lt')) {
      final l$backstory_lt = data['backstory_lt'];
      result$data['backstory_lt'] = (l$backstory_lt as String?);
    }
    if (data.containsKey('backstory_lte')) {
      final l$backstory_lte = data['backstory_lte'];
      result$data['backstory_lte'] = (l$backstory_lte as String?);
    }
    if (data.containsKey('description_eq')) {
      final l$description_eq = data['description_eq'];
      result$data['description_eq'] = (l$description_eq as String?);
    }
    if (data.containsKey('description_exists')) {
      final l$description_exists = data['description_exists'];
      result$data['description_exists'] = (l$description_exists as bool?);
    }
    if (data.containsKey('description_gt')) {
      final l$description_gt = data['description_gt'];
      result$data['description_gt'] = (l$description_gt as String?);
    }
    if (data.containsKey('description_gte')) {
      final l$description_gte = data['description_gte'];
      result$data['description_gte'] = (l$description_gte as String?);
    }
    if (data.containsKey('description_in')) {
      final l$description_in = data['description_in'];
      result$data['description_in'] = (l$description_in as List<dynamic>?)
          ?.map((e) => (e as String))
          .toList();
    }
    if (data.containsKey('description_lt')) {
      final l$description_lt = data['description_lt'];
      result$data['description_lt'] = (l$description_lt as String?);
    }
    if (data.containsKey('description_lte')) {
      final l$description_lte = data['description_lte'];
      result$data['description_lte'] = (l$description_lte as String?);
    }
    if (data.containsKey('filter_eq')) {
      final l$filter_eq = data['filter_eq'];
      result$data['filter_eq'] = (l$filter_eq as Map<String, dynamic>?);
    }
    if (data.containsKey('filter_exists')) {
      final l$filter_exists = data['filter_exists'];
      result$data['filter_exists'] = (l$filter_exists as bool?);
    }
    if (data.containsKey('filter_gt')) {
      final l$filter_gt = data['filter_gt'];
      result$data['filter_gt'] = (l$filter_gt as Map<String, dynamic>?);
    }
    if (data.containsKey('filter_gte')) {
      final l$filter_gte = data['filter_gte'];
      result$data['filter_gte'] = (l$filter_gte as Map<String, dynamic>?);
    }
    if (data.containsKey('filter_in')) {
      final l$filter_in = data['filter_in'];
      result$data['filter_in'] = (l$filter_in as List<dynamic>?)
          ?.map((e) => (e as Map<String, dynamic>))
          .toList();
    }
    if (data.containsKey('filter_lt')) {
      final l$filter_lt = data['filter_lt'];
      result$data['filter_lt'] = (l$filter_lt as Map<String, dynamic>?);
    }
    if (data.containsKey('filter_lte')) {
      final l$filter_lte = data['filter_lte'];
      result$data['filter_lte'] = (l$filter_lte as Map<String, dynamic>?);
    }
    if (data.containsKey('isPublic_eq')) {
      final l$isPublic_eq = data['isPublic_eq'];
      result$data['isPublic_eq'] = (l$isPublic_eq as bool?);
    }
    if (data.containsKey('isPublic_exists')) {
      final l$isPublic_exists = data['isPublic_exists'];
      result$data['isPublic_exists'] = (l$isPublic_exists as bool?);
    }
    if (data.containsKey('isPublic_gt')) {
      final l$isPublic_gt = data['isPublic_gt'];
      result$data['isPublic_gt'] = (l$isPublic_gt as bool?);
    }
    if (data.containsKey('isPublic_gte')) {
      final l$isPublic_gte = data['isPublic_gte'];
      result$data['isPublic_gte'] = (l$isPublic_gte as bool?);
    }
    if (data.containsKey('isPublic_in')) {
      final l$isPublic_in = data['isPublic_in'];
      result$data['isPublic_in'] =
          (l$isPublic_in as List<dynamic>?)?.map((e) => (e as bool)).toList();
    }
    if (data.containsKey('isPublic_lt')) {
      final l$isPublic_lt = data['isPublic_lt'];
      result$data['isPublic_lt'] = (l$isPublic_lt as bool?);
    }
    if (data.containsKey('isPublic_lte')) {
      final l$isPublic_lte = data['isPublic_lte'];
      result$data['isPublic_lte'] = (l$isPublic_lte as bool?);
    }
    if (data.containsKey('job_eq')) {
      final l$job_eq = data['job_eq'];
      result$data['job_eq'] = (l$job_eq as String?);
    }
    if (data.containsKey('job_exists')) {
      final l$job_exists = data['job_exists'];
      result$data['job_exists'] = (l$job_exists as bool?);
    }
    if (data.containsKey('job_gt')) {
      final l$job_gt = data['job_gt'];
      result$data['job_gt'] = (l$job_gt as String?);
    }
    if (data.containsKey('job_gte')) {
      final l$job_gte = data['job_gte'];
      result$data['job_gte'] = (l$job_gte as String?);
    }
    if (data.containsKey('job_in')) {
      final l$job_in = data['job_in'];
      result$data['job_in'] =
          (l$job_in as List<dynamic>?)?.map((e) => (e as String)).toList();
    }
    if (data.containsKey('job_lt')) {
      final l$job_lt = data['job_lt'];
      result$data['job_lt'] = (l$job_lt as String?);
    }
    if (data.containsKey('job_lte')) {
      final l$job_lte = data['job_lte'];
      result$data['job_lte'] = (l$job_lte as String?);
    }
    if (data.containsKey('modelName_eq')) {
      final l$modelName_eq = data['modelName_eq'];
      result$data['modelName_eq'] = (l$modelName_eq as String?);
    }
    if (data.containsKey('modelName_exists')) {
      final l$modelName_exists = data['modelName_exists'];
      result$data['modelName_exists'] = (l$modelName_exists as bool?);
    }
    if (data.containsKey('modelName_gt')) {
      final l$modelName_gt = data['modelName_gt'];
      result$data['modelName_gt'] = (l$modelName_gt as String?);
    }
    if (data.containsKey('modelName_gte')) {
      final l$modelName_gte = data['modelName_gte'];
      result$data['modelName_gte'] = (l$modelName_gte as String?);
    }
    if (data.containsKey('modelName_in')) {
      final l$modelName_in = data['modelName_in'];
      result$data['modelName_in'] = (l$modelName_in as List<dynamic>?)
          ?.map((e) => (e as String))
          .toList();
    }
    if (data.containsKey('modelName_lt')) {
      final l$modelName_lt = data['modelName_lt'];
      result$data['modelName_lt'] = (l$modelName_lt as String?);
    }
    if (data.containsKey('modelName_lte')) {
      final l$modelName_lte = data['modelName_lte'];
      result$data['modelName_lte'] = (l$modelName_lte as String?);
    }
    if (data.containsKey('name_eq')) {
      final l$name_eq = data['name_eq'];
      result$data['name_eq'] = (l$name_eq as String?);
    }
    if (data.containsKey('name_exists')) {
      final l$name_exists = data['name_exists'];
      result$data['name_exists'] = (l$name_exists as bool?);
    }
    if (data.containsKey('name_gt')) {
      final l$name_gt = data['name_gt'];
      result$data['name_gt'] = (l$name_gt as String?);
    }
    if (data.containsKey('name_gte')) {
      final l$name_gte = data['name_gte'];
      result$data['name_gte'] = (l$name_gte as String?);
    }
    if (data.containsKey('name_in')) {
      final l$name_in = data['name_in'];
      result$data['name_in'] =
          (l$name_in as List<dynamic>?)?.map((e) => (e as String)).toList();
    }
    if (data.containsKey('name_lt')) {
      final l$name_lt = data['name_lt'];
      result$data['name_lt'] = (l$name_lt as String?);
    }
    if (data.containsKey('name_lte')) {
      final l$name_lte = data['name_lte'];
      result$data['name_lte'] = (l$name_lte as String?);
    }
    if (data.containsKey('openaiApiKey_eq')) {
      final l$openaiApiKey_eq = data['openaiApiKey_eq'];
      result$data['openaiApiKey_eq'] = (l$openaiApiKey_eq as String?);
    }
    if (data.containsKey('openaiApiKey_exists')) {
      final l$openaiApiKey_exists = data['openaiApiKey_exists'];
      result$data['openaiApiKey_exists'] = (l$openaiApiKey_exists as bool?);
    }
    if (data.containsKey('openaiApiKey_gt')) {
      final l$openaiApiKey_gt = data['openaiApiKey_gt'];
      result$data['openaiApiKey_gt'] = (l$openaiApiKey_gt as String?);
    }
    if (data.containsKey('openaiApiKey_gte')) {
      final l$openaiApiKey_gte = data['openaiApiKey_gte'];
      result$data['openaiApiKey_gte'] = (l$openaiApiKey_gte as String?);
    }
    if (data.containsKey('openaiApiKey_in')) {
      final l$openaiApiKey_in = data['openaiApiKey_in'];
      result$data['openaiApiKey_in'] = (l$openaiApiKey_in as List<dynamic>?)
          ?.map((e) => (e as String))
          .toList();
    }
    if (data.containsKey('openaiApiKey_lt')) {
      final l$openaiApiKey_lt = data['openaiApiKey_lt'];
      result$data['openaiApiKey_lt'] = (l$openaiApiKey_lt as String?);
    }
    if (data.containsKey('openaiApiKey_lte')) {
      final l$openaiApiKey_lte = data['openaiApiKey_lte'];
      result$data['openaiApiKey_lte'] = (l$openaiApiKey_lte as String?);
    }
    if (data.containsKey('systemMessage_eq')) {
      final l$systemMessage_eq = data['systemMessage_eq'];
      result$data['systemMessage_eq'] = (l$systemMessage_eq as String?);
    }
    if (data.containsKey('systemMessage_exists')) {
      final l$systemMessage_exists = data['systemMessage_exists'];
      result$data['systemMessage_exists'] = (l$systemMessage_exists as bool?);
    }
    if (data.containsKey('systemMessage_gt')) {
      final l$systemMessage_gt = data['systemMessage_gt'];
      result$data['systemMessage_gt'] = (l$systemMessage_gt as String?);
    }
    if (data.containsKey('systemMessage_gte')) {
      final l$systemMessage_gte = data['systemMessage_gte'];
      result$data['systemMessage_gte'] = (l$systemMessage_gte as String?);
    }
    if (data.containsKey('systemMessage_in')) {
      final l$systemMessage_in = data['systemMessage_in'];
      result$data['systemMessage_in'] = (l$systemMessage_in as List<dynamic>?)
          ?.map((e) => (e as String))
          .toList();
    }
    if (data.containsKey('systemMessage_lt')) {
      final l$systemMessage_lt = data['systemMessage_lt'];
      result$data['systemMessage_lt'] = (l$systemMessage_lt as String?);
    }
    if (data.containsKey('systemMessage_lte')) {
      final l$systemMessage_lte = data['systemMessage_lte'];
      result$data['systemMessage_lte'] = (l$systemMessage_lte as String?);
    }
    if (data.containsKey('temperature_eq')) {
      final l$temperature_eq = data['temperature_eq'];
      result$data['temperature_eq'] = (l$temperature_eq as num?)?.toDouble();
    }
    if (data.containsKey('temperature_exists')) {
      final l$temperature_exists = data['temperature_exists'];
      result$data['temperature_exists'] = (l$temperature_exists as bool?);
    }
    if (data.containsKey('temperature_gt')) {
      final l$temperature_gt = data['temperature_gt'];
      result$data['temperature_gt'] = (l$temperature_gt as num?)?.toDouble();
    }
    if (data.containsKey('temperature_gte')) {
      final l$temperature_gte = data['temperature_gte'];
      result$data['temperature_gte'] = (l$temperature_gte as num?)?.toDouble();
    }
    if (data.containsKey('temperature_in')) {
      final l$temperature_in = data['temperature_in'];
      result$data['temperature_in'] = (l$temperature_in as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList();
    }
    if (data.containsKey('temperature_lt')) {
      final l$temperature_lt = data['temperature_lt'];
      result$data['temperature_lt'] = (l$temperature_lt as num?)?.toDouble();
    }
    if (data.containsKey('temperature_lte')) {
      final l$temperature_lte = data['temperature_lte'];
      result$data['temperature_lte'] = (l$temperature_lte as num?)?.toDouble();
    }
    if (data.containsKey('topP_eq')) {
      final l$topP_eq = data['topP_eq'];
      result$data['topP_eq'] = (l$topP_eq as num?)?.toDouble();
    }
    if (data.containsKey('topP_exists')) {
      final l$topP_exists = data['topP_exists'];
      result$data['topP_exists'] = (l$topP_exists as bool?);
    }
    if (data.containsKey('topP_gt')) {
      final l$topP_gt = data['topP_gt'];
      result$data['topP_gt'] = (l$topP_gt as num?)?.toDouble();
    }
    if (data.containsKey('topP_gte')) {
      final l$topP_gte = data['topP_gte'];
      result$data['topP_gte'] = (l$topP_gte as num?)?.toDouble();
    }
    if (data.containsKey('topP_in')) {
      final l$topP_in = data['topP_in'];
      result$data['topP_in'] = (l$topP_in as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList();
    }
    if (data.containsKey('topP_lt')) {
      final l$topP_lt = data['topP_lt'];
      result$data['topP_lt'] = (l$topP_lt as num?)?.toDouble();
    }
    if (data.containsKey('topP_lte')) {
      final l$topP_lte = data['topP_lte'];
      result$data['topP_lte'] = (l$topP_lte as num?)?.toDouble();
    }
    if (data.containsKey('user_eq')) {
      final l$user_eq = data['user_eq'];
      result$data['user_eq'] = (l$user_eq as String?);
    }
    if (data.containsKey('user_exists')) {
      final l$user_exists = data['user_exists'];
      result$data['user_exists'] = (l$user_exists as bool?);
    }
    if (data.containsKey('user_gt')) {
      final l$user_gt = data['user_gt'];
      result$data['user_gt'] = (l$user_gt as String?);
    }
    if (data.containsKey('user_gte')) {
      final l$user_gte = data['user_gte'];
      result$data['user_gte'] = (l$user_gte as String?);
    }
    if (data.containsKey('user_in')) {
      final l$user_in = data['user_in'];
      result$data['user_in'] =
          (l$user_in as List<dynamic>?)?.map((e) => (e as String)).toList();
    }
    if (data.containsKey('user_lt')) {
      final l$user_lt = data['user_lt'];
      result$data['user_lt'] = (l$user_lt as String?);
    }
    if (data.containsKey('user_lte')) {
      final l$user_lte = data['user_lte'];
      result$data['user_lte'] = (l$user_lte as String?);
    }
    if (data.containsKey('welcomeMessage_eq')) {
      final l$welcomeMessage_eq = data['welcomeMessage_eq'];
      result$data['welcomeMessage_eq'] = (l$welcomeMessage_eq as String?);
    }
    if (data.containsKey('welcomeMessage_exists')) {
      final l$welcomeMessage_exists = data['welcomeMessage_exists'];
      result$data['welcomeMessage_exists'] = (l$welcomeMessage_exists as bool?);
    }
    if (data.containsKey('welcomeMessage_gt')) {
      final l$welcomeMessage_gt = data['welcomeMessage_gt'];
      result$data['welcomeMessage_gt'] = (l$welcomeMessage_gt as String?);
    }
    if (data.containsKey('welcomeMessage_gte')) {
      final l$welcomeMessage_gte = data['welcomeMessage_gte'];
      result$data['welcomeMessage_gte'] = (l$welcomeMessage_gte as String?);
    }
    if (data.containsKey('welcomeMessage_in')) {
      final l$welcomeMessage_in = data['welcomeMessage_in'];
      result$data['welcomeMessage_in'] = (l$welcomeMessage_in as List<dynamic>?)
          ?.map((e) => (e as String))
          .toList();
    }
    if (data.containsKey('welcomeMessage_lt')) {
      final l$welcomeMessage_lt = data['welcomeMessage_lt'];
      result$data['welcomeMessage_lt'] = (l$welcomeMessage_lt as String?);
    }
    if (data.containsKey('welcomeMessage_lte')) {
      final l$welcomeMessage_lte = data['welcomeMessage_lte'];
      result$data['welcomeMessage_lte'] = (l$welcomeMessage_lte as String?);
    }
    if (data.containsKey('welcomeMetadata_eq')) {
      final l$welcomeMetadata_eq = data['welcomeMetadata_eq'];
      result$data['welcomeMetadata_eq'] =
          (l$welcomeMetadata_eq as Map<String, dynamic>?);
    }
    if (data.containsKey('welcomeMetadata_exists')) {
      final l$welcomeMetadata_exists = data['welcomeMetadata_exists'];
      result$data['welcomeMetadata_exists'] =
          (l$welcomeMetadata_exists as bool?);
    }
    if (data.containsKey('welcomeMetadata_gt')) {
      final l$welcomeMetadata_gt = data['welcomeMetadata_gt'];
      result$data['welcomeMetadata_gt'] =
          (l$welcomeMetadata_gt as Map<String, dynamic>?);
    }
    if (data.containsKey('welcomeMetadata_gte')) {
      final l$welcomeMetadata_gte = data['welcomeMetadata_gte'];
      result$data['welcomeMetadata_gte'] =
          (l$welcomeMetadata_gte as Map<String, dynamic>?);
    }
    if (data.containsKey('welcomeMetadata_in')) {
      final l$welcomeMetadata_in = data['welcomeMetadata_in'];
      result$data['welcomeMetadata_in'] =
          (l$welcomeMetadata_in as List<dynamic>?)
              ?.map((e) => (e as Map<String, dynamic>))
              .toList();
    }
    if (data.containsKey('welcomeMetadata_lt')) {
      final l$welcomeMetadata_lt = data['welcomeMetadata_lt'];
      result$data['welcomeMetadata_lt'] =
          (l$welcomeMetadata_lt as Map<String, dynamic>?);
    }
    if (data.containsKey('welcomeMetadata_lte')) {
      final l$welcomeMetadata_lte = data['welcomeMetadata_lte'];
      result$data['welcomeMetadata_lte'] =
          (l$welcomeMetadata_lte as Map<String, dynamic>?);
    }
    return Input$ConfigFilter._(result$data);
  }

  Map<String, dynamic> _$data;

  String? get $_id_eq => (_$data['_id_eq'] as String?);
  bool? get $_id_exists => (_$data['_id_exists'] as bool?);
  String? get $_id_gt => (_$data['_id_gt'] as String?);
  String? get $_id_gte => (_$data['_id_gte'] as String?);
  List<String>? get $_id_in => (_$data['_id_in'] as List<String>?);
  String? get $_id_lt => (_$data['_id_lt'] as String?);
  String? get $_id_lte => (_$data['_id_lte'] as String?);
  String? get createdAt_eq => (_$data['createdAt_eq'] as String?);
  bool? get createdAt_exists => (_$data['createdAt_exists'] as bool?);
  String? get createdAt_gt => (_$data['createdAt_gt'] as String?);
  String? get createdAt_gte => (_$data['createdAt_gte'] as String?);
  List<String>? get createdAt_in => (_$data['createdAt_in'] as List<String>?);
  String? get createdAt_lt => (_$data['createdAt_lt'] as String?);
  String? get createdAt_lte => (_$data['createdAt_lte'] as String?);
  String? get updatedAt_eq => (_$data['updatedAt_eq'] as String?);
  bool? get updatedAt_exists => (_$data['updatedAt_exists'] as bool?);
  String? get updatedAt_gt => (_$data['updatedAt_gt'] as String?);
  String? get updatedAt_gte => (_$data['updatedAt_gte'] as String?);
  List<String>? get updatedAt_in => (_$data['updatedAt_in'] as List<String>?);
  String? get updatedAt_lt => (_$data['updatedAt_lt'] as String?);
  String? get updatedAt_lte => (_$data['updatedAt_lte'] as String?);
  String? get avatar_eq => (_$data['avatar_eq'] as String?);
  bool? get avatar_exists => (_$data['avatar_exists'] as bool?);
  String? get avatar_gt => (_$data['avatar_gt'] as String?);
  String? get avatar_gte => (_$data['avatar_gte'] as String?);
  List<String>? get avatar_in => (_$data['avatar_in'] as List<String>?);
  String? get avatar_lt => (_$data['avatar_lt'] as String?);
  String? get avatar_lte => (_$data['avatar_lte'] as String?);
  String? get backstory_eq => (_$data['backstory_eq'] as String?);
  bool? get backstory_exists => (_$data['backstory_exists'] as bool?);
  String? get backstory_gt => (_$data['backstory_gt'] as String?);
  String? get backstory_gte => (_$data['backstory_gte'] as String?);
  List<String>? get backstory_in => (_$data['backstory_in'] as List<String>?);
  String? get backstory_lt => (_$data['backstory_lt'] as String?);
  String? get backstory_lte => (_$data['backstory_lte'] as String?);
  String? get description_eq => (_$data['description_eq'] as String?);
  bool? get description_exists => (_$data['description_exists'] as bool?);
  String? get description_gt => (_$data['description_gt'] as String?);
  String? get description_gte => (_$data['description_gte'] as String?);
  List<String>? get description_in =>
      (_$data['description_in'] as List<String>?);
  String? get description_lt => (_$data['description_lt'] as String?);
  String? get description_lte => (_$data['description_lte'] as String?);
  Map<String, dynamic>? get filter_eq =>
      (_$data['filter_eq'] as Map<String, dynamic>?);
  bool? get filter_exists => (_$data['filter_exists'] as bool?);
  Map<String, dynamic>? get filter_gt =>
      (_$data['filter_gt'] as Map<String, dynamic>?);
  Map<String, dynamic>? get filter_gte =>
      (_$data['filter_gte'] as Map<String, dynamic>?);
  List<Map<String, dynamic>>? get filter_in =>
      (_$data['filter_in'] as List<Map<String, dynamic>>?);
  Map<String, dynamic>? get filter_lt =>
      (_$data['filter_lt'] as Map<String, dynamic>?);
  Map<String, dynamic>? get filter_lte =>
      (_$data['filter_lte'] as Map<String, dynamic>?);
  bool? get isPublic_eq => (_$data['isPublic_eq'] as bool?);
  bool? get isPublic_exists => (_$data['isPublic_exists'] as bool?);
  bool? get isPublic_gt => (_$data['isPublic_gt'] as bool?);
  bool? get isPublic_gte => (_$data['isPublic_gte'] as bool?);
  List<bool>? get isPublic_in => (_$data['isPublic_in'] as List<bool>?);
  bool? get isPublic_lt => (_$data['isPublic_lt'] as bool?);
  bool? get isPublic_lte => (_$data['isPublic_lte'] as bool?);
  String? get job_eq => (_$data['job_eq'] as String?);
  bool? get job_exists => (_$data['job_exists'] as bool?);
  String? get job_gt => (_$data['job_gt'] as String?);
  String? get job_gte => (_$data['job_gte'] as String?);
  List<String>? get job_in => (_$data['job_in'] as List<String>?);
  String? get job_lt => (_$data['job_lt'] as String?);
  String? get job_lte => (_$data['job_lte'] as String?);
  String? get modelName_eq => (_$data['modelName_eq'] as String?);
  bool? get modelName_exists => (_$data['modelName_exists'] as bool?);
  String? get modelName_gt => (_$data['modelName_gt'] as String?);
  String? get modelName_gte => (_$data['modelName_gte'] as String?);
  List<String>? get modelName_in => (_$data['modelName_in'] as List<String>?);
  String? get modelName_lt => (_$data['modelName_lt'] as String?);
  String? get modelName_lte => (_$data['modelName_lte'] as String?);
  String? get name_eq => (_$data['name_eq'] as String?);
  bool? get name_exists => (_$data['name_exists'] as bool?);
  String? get name_gt => (_$data['name_gt'] as String?);
  String? get name_gte => (_$data['name_gte'] as String?);
  List<String>? get name_in => (_$data['name_in'] as List<String>?);
  String? get name_lt => (_$data['name_lt'] as String?);
  String? get name_lte => (_$data['name_lte'] as String?);
  String? get openaiApiKey_eq => (_$data['openaiApiKey_eq'] as String?);
  bool? get openaiApiKey_exists => (_$data['openaiApiKey_exists'] as bool?);
  String? get openaiApiKey_gt => (_$data['openaiApiKey_gt'] as String?);
  String? get openaiApiKey_gte => (_$data['openaiApiKey_gte'] as String?);
  List<String>? get openaiApiKey_in =>
      (_$data['openaiApiKey_in'] as List<String>?);
  String? get openaiApiKey_lt => (_$data['openaiApiKey_lt'] as String?);
  String? get openaiApiKey_lte => (_$data['openaiApiKey_lte'] as String?);
  String? get systemMessage_eq => (_$data['systemMessage_eq'] as String?);
  bool? get systemMessage_exists => (_$data['systemMessage_exists'] as bool?);
  String? get systemMessage_gt => (_$data['systemMessage_gt'] as String?);
  String? get systemMessage_gte => (_$data['systemMessage_gte'] as String?);
  List<String>? get systemMessage_in =>
      (_$data['systemMessage_in'] as List<String>?);
  String? get systemMessage_lt => (_$data['systemMessage_lt'] as String?);
  String? get systemMessage_lte => (_$data['systemMessage_lte'] as String?);
  double? get temperature_eq => (_$data['temperature_eq'] as double?);
  bool? get temperature_exists => (_$data['temperature_exists'] as bool?);
  double? get temperature_gt => (_$data['temperature_gt'] as double?);
  double? get temperature_gte => (_$data['temperature_gte'] as double?);
  List<double>? get temperature_in =>
      (_$data['temperature_in'] as List<double>?);
  double? get temperature_lt => (_$data['temperature_lt'] as double?);
  double? get temperature_lte => (_$data['temperature_lte'] as double?);
  double? get topP_eq => (_$data['topP_eq'] as double?);
  bool? get topP_exists => (_$data['topP_exists'] as bool?);
  double? get topP_gt => (_$data['topP_gt'] as double?);
  double? get topP_gte => (_$data['topP_gte'] as double?);
  List<double>? get topP_in => (_$data['topP_in'] as List<double>?);
  double? get topP_lt => (_$data['topP_lt'] as double?);
  double? get topP_lte => (_$data['topP_lte'] as double?);
  String? get user_eq => (_$data['user_eq'] as String?);
  bool? get user_exists => (_$data['user_exists'] as bool?);
  String? get user_gt => (_$data['user_gt'] as String?);
  String? get user_gte => (_$data['user_gte'] as String?);
  List<String>? get user_in => (_$data['user_in'] as List<String>?);
  String? get user_lt => (_$data['user_lt'] as String?);
  String? get user_lte => (_$data['user_lte'] as String?);
  String? get welcomeMessage_eq => (_$data['welcomeMessage_eq'] as String?);
  bool? get welcomeMessage_exists => (_$data['welcomeMessage_exists'] as bool?);
  String? get welcomeMessage_gt => (_$data['welcomeMessage_gt'] as String?);
  String? get welcomeMessage_gte => (_$data['welcomeMessage_gte'] as String?);
  List<String>? get welcomeMessage_in =>
      (_$data['welcomeMessage_in'] as List<String>?);
  String? get welcomeMessage_lt => (_$data['welcomeMessage_lt'] as String?);
  String? get welcomeMessage_lte => (_$data['welcomeMessage_lte'] as String?);
  Map<String, dynamic>? get welcomeMetadata_eq =>
      (_$data['welcomeMetadata_eq'] as Map<String, dynamic>?);
  bool? get welcomeMetadata_exists =>
      (_$data['welcomeMetadata_exists'] as bool?);
  Map<String, dynamic>? get welcomeMetadata_gt =>
      (_$data['welcomeMetadata_gt'] as Map<String, dynamic>?);
  Map<String, dynamic>? get welcomeMetadata_gte =>
      (_$data['welcomeMetadata_gte'] as Map<String, dynamic>?);
  List<Map<String, dynamic>>? get welcomeMetadata_in =>
      (_$data['welcomeMetadata_in'] as List<Map<String, dynamic>>?);
  Map<String, dynamic>? get welcomeMetadata_lt =>
      (_$data['welcomeMetadata_lt'] as Map<String, dynamic>?);
  Map<String, dynamic>? get welcomeMetadata_lte =>
      (_$data['welcomeMetadata_lte'] as Map<String, dynamic>?);
  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    if (_$data.containsKey('_id_eq')) {
      final l$$_id_eq = $_id_eq;
      result$data['_id_eq'] = l$$_id_eq;
    }
    if (_$data.containsKey('_id_exists')) {
      final l$$_id_exists = $_id_exists;
      result$data['_id_exists'] = l$$_id_exists;
    }
    if (_$data.containsKey('_id_gt')) {
      final l$$_id_gt = $_id_gt;
      result$data['_id_gt'] = l$$_id_gt;
    }
    if (_$data.containsKey('_id_gte')) {
      final l$$_id_gte = $_id_gte;
      result$data['_id_gte'] = l$$_id_gte;
    }
    if (_$data.containsKey('_id_in')) {
      final l$$_id_in = $_id_in;
      result$data['_id_in'] = l$$_id_in?.map((e) => e).toList();
    }
    if (_$data.containsKey('_id_lt')) {
      final l$$_id_lt = $_id_lt;
      result$data['_id_lt'] = l$$_id_lt;
    }
    if (_$data.containsKey('_id_lte')) {
      final l$$_id_lte = $_id_lte;
      result$data['_id_lte'] = l$$_id_lte;
    }
    if (_$data.containsKey('createdAt_eq')) {
      final l$createdAt_eq = createdAt_eq;
      result$data['createdAt_eq'] = l$createdAt_eq;
    }
    if (_$data.containsKey('createdAt_exists')) {
      final l$createdAt_exists = createdAt_exists;
      result$data['createdAt_exists'] = l$createdAt_exists;
    }
    if (_$data.containsKey('createdAt_gt')) {
      final l$createdAt_gt = createdAt_gt;
      result$data['createdAt_gt'] = l$createdAt_gt;
    }
    if (_$data.containsKey('createdAt_gte')) {
      final l$createdAt_gte = createdAt_gte;
      result$data['createdAt_gte'] = l$createdAt_gte;
    }
    if (_$data.containsKey('createdAt_in')) {
      final l$createdAt_in = createdAt_in;
      result$data['createdAt_in'] = l$createdAt_in?.map((e) => e).toList();
    }
    if (_$data.containsKey('createdAt_lt')) {
      final l$createdAt_lt = createdAt_lt;
      result$data['createdAt_lt'] = l$createdAt_lt;
    }
    if (_$data.containsKey('createdAt_lte')) {
      final l$createdAt_lte = createdAt_lte;
      result$data['createdAt_lte'] = l$createdAt_lte;
    }
    if (_$data.containsKey('updatedAt_eq')) {
      final l$updatedAt_eq = updatedAt_eq;
      result$data['updatedAt_eq'] = l$updatedAt_eq;
    }
    if (_$data.containsKey('updatedAt_exists')) {
      final l$updatedAt_exists = updatedAt_exists;
      result$data['updatedAt_exists'] = l$updatedAt_exists;
    }
    if (_$data.containsKey('updatedAt_gt')) {
      final l$updatedAt_gt = updatedAt_gt;
      result$data['updatedAt_gt'] = l$updatedAt_gt;
    }
    if (_$data.containsKey('updatedAt_gte')) {
      final l$updatedAt_gte = updatedAt_gte;
      result$data['updatedAt_gte'] = l$updatedAt_gte;
    }
    if (_$data.containsKey('updatedAt_in')) {
      final l$updatedAt_in = updatedAt_in;
      result$data['updatedAt_in'] = l$updatedAt_in?.map((e) => e).toList();
    }
    if (_$data.containsKey('updatedAt_lt')) {
      final l$updatedAt_lt = updatedAt_lt;
      result$data['updatedAt_lt'] = l$updatedAt_lt;
    }
    if (_$data.containsKey('updatedAt_lte')) {
      final l$updatedAt_lte = updatedAt_lte;
      result$data['updatedAt_lte'] = l$updatedAt_lte;
    }
    if (_$data.containsKey('avatar_eq')) {
      final l$avatar_eq = avatar_eq;
      result$data['avatar_eq'] = l$avatar_eq;
    }
    if (_$data.containsKey('avatar_exists')) {
      final l$avatar_exists = avatar_exists;
      result$data['avatar_exists'] = l$avatar_exists;
    }
    if (_$data.containsKey('avatar_gt')) {
      final l$avatar_gt = avatar_gt;
      result$data['avatar_gt'] = l$avatar_gt;
    }
    if (_$data.containsKey('avatar_gte')) {
      final l$avatar_gte = avatar_gte;
      result$data['avatar_gte'] = l$avatar_gte;
    }
    if (_$data.containsKey('avatar_in')) {
      final l$avatar_in = avatar_in;
      result$data['avatar_in'] = l$avatar_in?.map((e) => e).toList();
    }
    if (_$data.containsKey('avatar_lt')) {
      final l$avatar_lt = avatar_lt;
      result$data['avatar_lt'] = l$avatar_lt;
    }
    if (_$data.containsKey('avatar_lte')) {
      final l$avatar_lte = avatar_lte;
      result$data['avatar_lte'] = l$avatar_lte;
    }
    if (_$data.containsKey('backstory_eq')) {
      final l$backstory_eq = backstory_eq;
      result$data['backstory_eq'] = l$backstory_eq;
    }
    if (_$data.containsKey('backstory_exists')) {
      final l$backstory_exists = backstory_exists;
      result$data['backstory_exists'] = l$backstory_exists;
    }
    if (_$data.containsKey('backstory_gt')) {
      final l$backstory_gt = backstory_gt;
      result$data['backstory_gt'] = l$backstory_gt;
    }
    if (_$data.containsKey('backstory_gte')) {
      final l$backstory_gte = backstory_gte;
      result$data['backstory_gte'] = l$backstory_gte;
    }
    if (_$data.containsKey('backstory_in')) {
      final l$backstory_in = backstory_in;
      result$data['backstory_in'] = l$backstory_in?.map((e) => e).toList();
    }
    if (_$data.containsKey('backstory_lt')) {
      final l$backstory_lt = backstory_lt;
      result$data['backstory_lt'] = l$backstory_lt;
    }
    if (_$data.containsKey('backstory_lte')) {
      final l$backstory_lte = backstory_lte;
      result$data['backstory_lte'] = l$backstory_lte;
    }
    if (_$data.containsKey('description_eq')) {
      final l$description_eq = description_eq;
      result$data['description_eq'] = l$description_eq;
    }
    if (_$data.containsKey('description_exists')) {
      final l$description_exists = description_exists;
      result$data['description_exists'] = l$description_exists;
    }
    if (_$data.containsKey('description_gt')) {
      final l$description_gt = description_gt;
      result$data['description_gt'] = l$description_gt;
    }
    if (_$data.containsKey('description_gte')) {
      final l$description_gte = description_gte;
      result$data['description_gte'] = l$description_gte;
    }
    if (_$data.containsKey('description_in')) {
      final l$description_in = description_in;
      result$data['description_in'] = l$description_in?.map((e) => e).toList();
    }
    if (_$data.containsKey('description_lt')) {
      final l$description_lt = description_lt;
      result$data['description_lt'] = l$description_lt;
    }
    if (_$data.containsKey('description_lte')) {
      final l$description_lte = description_lte;
      result$data['description_lte'] = l$description_lte;
    }
    if (_$data.containsKey('filter_eq')) {
      final l$filter_eq = filter_eq;
      result$data['filter_eq'] = l$filter_eq;
    }
    if (_$data.containsKey('filter_exists')) {
      final l$filter_exists = filter_exists;
      result$data['filter_exists'] = l$filter_exists;
    }
    if (_$data.containsKey('filter_gt')) {
      final l$filter_gt = filter_gt;
      result$data['filter_gt'] = l$filter_gt;
    }
    if (_$data.containsKey('filter_gte')) {
      final l$filter_gte = filter_gte;
      result$data['filter_gte'] = l$filter_gte;
    }
    if (_$data.containsKey('filter_in')) {
      final l$filter_in = filter_in;
      result$data['filter_in'] = l$filter_in?.map((e) => e).toList();
    }
    if (_$data.containsKey('filter_lt')) {
      final l$filter_lt = filter_lt;
      result$data['filter_lt'] = l$filter_lt;
    }
    if (_$data.containsKey('filter_lte')) {
      final l$filter_lte = filter_lte;
      result$data['filter_lte'] = l$filter_lte;
    }
    if (_$data.containsKey('isPublic_eq')) {
      final l$isPublic_eq = isPublic_eq;
      result$data['isPublic_eq'] = l$isPublic_eq;
    }
    if (_$data.containsKey('isPublic_exists')) {
      final l$isPublic_exists = isPublic_exists;
      result$data['isPublic_exists'] = l$isPublic_exists;
    }
    if (_$data.containsKey('isPublic_gt')) {
      final l$isPublic_gt = isPublic_gt;
      result$data['isPublic_gt'] = l$isPublic_gt;
    }
    if (_$data.containsKey('isPublic_gte')) {
      final l$isPublic_gte = isPublic_gte;
      result$data['isPublic_gte'] = l$isPublic_gte;
    }
    if (_$data.containsKey('isPublic_in')) {
      final l$isPublic_in = isPublic_in;
      result$data['isPublic_in'] = l$isPublic_in?.map((e) => e).toList();
    }
    if (_$data.containsKey('isPublic_lt')) {
      final l$isPublic_lt = isPublic_lt;
      result$data['isPublic_lt'] = l$isPublic_lt;
    }
    if (_$data.containsKey('isPublic_lte')) {
      final l$isPublic_lte = isPublic_lte;
      result$data['isPublic_lte'] = l$isPublic_lte;
    }
    if (_$data.containsKey('job_eq')) {
      final l$job_eq = job_eq;
      result$data['job_eq'] = l$job_eq;
    }
    if (_$data.containsKey('job_exists')) {
      final l$job_exists = job_exists;
      result$data['job_exists'] = l$job_exists;
    }
    if (_$data.containsKey('job_gt')) {
      final l$job_gt = job_gt;
      result$data['job_gt'] = l$job_gt;
    }
    if (_$data.containsKey('job_gte')) {
      final l$job_gte = job_gte;
      result$data['job_gte'] = l$job_gte;
    }
    if (_$data.containsKey('job_in')) {
      final l$job_in = job_in;
      result$data['job_in'] = l$job_in?.map((e) => e).toList();
    }
    if (_$data.containsKey('job_lt')) {
      final l$job_lt = job_lt;
      result$data['job_lt'] = l$job_lt;
    }
    if (_$data.containsKey('job_lte')) {
      final l$job_lte = job_lte;
      result$data['job_lte'] = l$job_lte;
    }
    if (_$data.containsKey('modelName_eq')) {
      final l$modelName_eq = modelName_eq;
      result$data['modelName_eq'] = l$modelName_eq;
    }
    if (_$data.containsKey('modelName_exists')) {
      final l$modelName_exists = modelName_exists;
      result$data['modelName_exists'] = l$modelName_exists;
    }
    if (_$data.containsKey('modelName_gt')) {
      final l$modelName_gt = modelName_gt;
      result$data['modelName_gt'] = l$modelName_gt;
    }
    if (_$data.containsKey('modelName_gte')) {
      final l$modelName_gte = modelName_gte;
      result$data['modelName_gte'] = l$modelName_gte;
    }
    if (_$data.containsKey('modelName_in')) {
      final l$modelName_in = modelName_in;
      result$data['modelName_in'] = l$modelName_in?.map((e) => e).toList();
    }
    if (_$data.containsKey('modelName_lt')) {
      final l$modelName_lt = modelName_lt;
      result$data['modelName_lt'] = l$modelName_lt;
    }
    if (_$data.containsKey('modelName_lte')) {
      final l$modelName_lte = modelName_lte;
      result$data['modelName_lte'] = l$modelName_lte;
    }
    if (_$data.containsKey('name_eq')) {
      final l$name_eq = name_eq;
      result$data['name_eq'] = l$name_eq;
    }
    if (_$data.containsKey('name_exists')) {
      final l$name_exists = name_exists;
      result$data['name_exists'] = l$name_exists;
    }
    if (_$data.containsKey('name_gt')) {
      final l$name_gt = name_gt;
      result$data['name_gt'] = l$name_gt;
    }
    if (_$data.containsKey('name_gte')) {
      final l$name_gte = name_gte;
      result$data['name_gte'] = l$name_gte;
    }
    if (_$data.containsKey('name_in')) {
      final l$name_in = name_in;
      result$data['name_in'] = l$name_in?.map((e) => e).toList();
    }
    if (_$data.containsKey('name_lt')) {
      final l$name_lt = name_lt;
      result$data['name_lt'] = l$name_lt;
    }
    if (_$data.containsKey('name_lte')) {
      final l$name_lte = name_lte;
      result$data['name_lte'] = l$name_lte;
    }
    if (_$data.containsKey('openaiApiKey_eq')) {
      final l$openaiApiKey_eq = openaiApiKey_eq;
      result$data['openaiApiKey_eq'] = l$openaiApiKey_eq;
    }
    if (_$data.containsKey('openaiApiKey_exists')) {
      final l$openaiApiKey_exists = openaiApiKey_exists;
      result$data['openaiApiKey_exists'] = l$openaiApiKey_exists;
    }
    if (_$data.containsKey('openaiApiKey_gt')) {
      final l$openaiApiKey_gt = openaiApiKey_gt;
      result$data['openaiApiKey_gt'] = l$openaiApiKey_gt;
    }
    if (_$data.containsKey('openaiApiKey_gte')) {
      final l$openaiApiKey_gte = openaiApiKey_gte;
      result$data['openaiApiKey_gte'] = l$openaiApiKey_gte;
    }
    if (_$data.containsKey('openaiApiKey_in')) {
      final l$openaiApiKey_in = openaiApiKey_in;
      result$data['openaiApiKey_in'] =
          l$openaiApiKey_in?.map((e) => e).toList();
    }
    if (_$data.containsKey('openaiApiKey_lt')) {
      final l$openaiApiKey_lt = openaiApiKey_lt;
      result$data['openaiApiKey_lt'] = l$openaiApiKey_lt;
    }
    if (_$data.containsKey('openaiApiKey_lte')) {
      final l$openaiApiKey_lte = openaiApiKey_lte;
      result$data['openaiApiKey_lte'] = l$openaiApiKey_lte;
    }
    if (_$data.containsKey('systemMessage_eq')) {
      final l$systemMessage_eq = systemMessage_eq;
      result$data['systemMessage_eq'] = l$systemMessage_eq;
    }
    if (_$data.containsKey('systemMessage_exists')) {
      final l$systemMessage_exists = systemMessage_exists;
      result$data['systemMessage_exists'] = l$systemMessage_exists;
    }
    if (_$data.containsKey('systemMessage_gt')) {
      final l$systemMessage_gt = systemMessage_gt;
      result$data['systemMessage_gt'] = l$systemMessage_gt;
    }
    if (_$data.containsKey('systemMessage_gte')) {
      final l$systemMessage_gte = systemMessage_gte;
      result$data['systemMessage_gte'] = l$systemMessage_gte;
    }
    if (_$data.containsKey('systemMessage_in')) {
      final l$systemMessage_in = systemMessage_in;
      result$data['systemMessage_in'] =
          l$systemMessage_in?.map((e) => e).toList();
    }
    if (_$data.containsKey('systemMessage_lt')) {
      final l$systemMessage_lt = systemMessage_lt;
      result$data['systemMessage_lt'] = l$systemMessage_lt;
    }
    if (_$data.containsKey('systemMessage_lte')) {
      final l$systemMessage_lte = systemMessage_lte;
      result$data['systemMessage_lte'] = l$systemMessage_lte;
    }
    if (_$data.containsKey('temperature_eq')) {
      final l$temperature_eq = temperature_eq;
      result$data['temperature_eq'] = l$temperature_eq;
    }
    if (_$data.containsKey('temperature_exists')) {
      final l$temperature_exists = temperature_exists;
      result$data['temperature_exists'] = l$temperature_exists;
    }
    if (_$data.containsKey('temperature_gt')) {
      final l$temperature_gt = temperature_gt;
      result$data['temperature_gt'] = l$temperature_gt;
    }
    if (_$data.containsKey('temperature_gte')) {
      final l$temperature_gte = temperature_gte;
      result$data['temperature_gte'] = l$temperature_gte;
    }
    if (_$data.containsKey('temperature_in')) {
      final l$temperature_in = temperature_in;
      result$data['temperature_in'] = l$temperature_in?.map((e) => e).toList();
    }
    if (_$data.containsKey('temperature_lt')) {
      final l$temperature_lt = temperature_lt;
      result$data['temperature_lt'] = l$temperature_lt;
    }
    if (_$data.containsKey('temperature_lte')) {
      final l$temperature_lte = temperature_lte;
      result$data['temperature_lte'] = l$temperature_lte;
    }
    if (_$data.containsKey('topP_eq')) {
      final l$topP_eq = topP_eq;
      result$data['topP_eq'] = l$topP_eq;
    }
    if (_$data.containsKey('topP_exists')) {
      final l$topP_exists = topP_exists;
      result$data['topP_exists'] = l$topP_exists;
    }
    if (_$data.containsKey('topP_gt')) {
      final l$topP_gt = topP_gt;
      result$data['topP_gt'] = l$topP_gt;
    }
    if (_$data.containsKey('topP_gte')) {
      final l$topP_gte = topP_gte;
      result$data['topP_gte'] = l$topP_gte;
    }
    if (_$data.containsKey('topP_in')) {
      final l$topP_in = topP_in;
      result$data['topP_in'] = l$topP_in?.map((e) => e).toList();
    }
    if (_$data.containsKey('topP_lt')) {
      final l$topP_lt = topP_lt;
      result$data['topP_lt'] = l$topP_lt;
    }
    if (_$data.containsKey('topP_lte')) {
      final l$topP_lte = topP_lte;
      result$data['topP_lte'] = l$topP_lte;
    }
    if (_$data.containsKey('user_eq')) {
      final l$user_eq = user_eq;
      result$data['user_eq'] = l$user_eq;
    }
    if (_$data.containsKey('user_exists')) {
      final l$user_exists = user_exists;
      result$data['user_exists'] = l$user_exists;
    }
    if (_$data.containsKey('user_gt')) {
      final l$user_gt = user_gt;
      result$data['user_gt'] = l$user_gt;
    }
    if (_$data.containsKey('user_gte')) {
      final l$user_gte = user_gte;
      result$data['user_gte'] = l$user_gte;
    }
    if (_$data.containsKey('user_in')) {
      final l$user_in = user_in;
      result$data['user_in'] = l$user_in?.map((e) => e).toList();
    }
    if (_$data.containsKey('user_lt')) {
      final l$user_lt = user_lt;
      result$data['user_lt'] = l$user_lt;
    }
    if (_$data.containsKey('user_lte')) {
      final l$user_lte = user_lte;
      result$data['user_lte'] = l$user_lte;
    }
    if (_$data.containsKey('welcomeMessage_eq')) {
      final l$welcomeMessage_eq = welcomeMessage_eq;
      result$data['welcomeMessage_eq'] = l$welcomeMessage_eq;
    }
    if (_$data.containsKey('welcomeMessage_exists')) {
      final l$welcomeMessage_exists = welcomeMessage_exists;
      result$data['welcomeMessage_exists'] = l$welcomeMessage_exists;
    }
    if (_$data.containsKey('welcomeMessage_gt')) {
      final l$welcomeMessage_gt = welcomeMessage_gt;
      result$data['welcomeMessage_gt'] = l$welcomeMessage_gt;
    }
    if (_$data.containsKey('welcomeMessage_gte')) {
      final l$welcomeMessage_gte = welcomeMessage_gte;
      result$data['welcomeMessage_gte'] = l$welcomeMessage_gte;
    }
    if (_$data.containsKey('welcomeMessage_in')) {
      final l$welcomeMessage_in = welcomeMessage_in;
      result$data['welcomeMessage_in'] =
          l$welcomeMessage_in?.map((e) => e).toList();
    }
    if (_$data.containsKey('welcomeMessage_lt')) {
      final l$welcomeMessage_lt = welcomeMessage_lt;
      result$data['welcomeMessage_lt'] = l$welcomeMessage_lt;
    }
    if (_$data.containsKey('welcomeMessage_lte')) {
      final l$welcomeMessage_lte = welcomeMessage_lte;
      result$data['welcomeMessage_lte'] = l$welcomeMessage_lte;
    }
    if (_$data.containsKey('welcomeMetadata_eq')) {
      final l$welcomeMetadata_eq = welcomeMetadata_eq;
      result$data['welcomeMetadata_eq'] = l$welcomeMetadata_eq;
    }
    if (_$data.containsKey('welcomeMetadata_exists')) {
      final l$welcomeMetadata_exists = welcomeMetadata_exists;
      result$data['welcomeMetadata_exists'] = l$welcomeMetadata_exists;
    }
    if (_$data.containsKey('welcomeMetadata_gt')) {
      final l$welcomeMetadata_gt = welcomeMetadata_gt;
      result$data['welcomeMetadata_gt'] = l$welcomeMetadata_gt;
    }
    if (_$data.containsKey('welcomeMetadata_gte')) {
      final l$welcomeMetadata_gte = welcomeMetadata_gte;
      result$data['welcomeMetadata_gte'] = l$welcomeMetadata_gte;
    }
    if (_$data.containsKey('welcomeMetadata_in')) {
      final l$welcomeMetadata_in = welcomeMetadata_in;
      result$data['welcomeMetadata_in'] =
          l$welcomeMetadata_in?.map((e) => e).toList();
    }
    if (_$data.containsKey('welcomeMetadata_lt')) {
      final l$welcomeMetadata_lt = welcomeMetadata_lt;
      result$data['welcomeMetadata_lt'] = l$welcomeMetadata_lt;
    }
    if (_$data.containsKey('welcomeMetadata_lte')) {
      final l$welcomeMetadata_lte = welcomeMetadata_lte;
      result$data['welcomeMetadata_lte'] = l$welcomeMetadata_lte;
    }
    return result$data;
  }

  CopyWith$Input$ConfigFilter<Input$ConfigFilter> get copyWith =>
      CopyWith$Input$ConfigFilter(
        this,
        (i) => i,
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Input$ConfigFilter) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$$_id_eq = $_id_eq;
    final lOther$$_id_eq = other.$_id_eq;
    if (_$data.containsKey('_id_eq') != other._$data.containsKey('_id_eq')) {
      return false;
    }
    if (l$$_id_eq != lOther$$_id_eq) {
      return false;
    }
    final l$$_id_exists = $_id_exists;
    final lOther$$_id_exists = other.$_id_exists;
    if (_$data.containsKey('_id_exists') !=
        other._$data.containsKey('_id_exists')) {
      return false;
    }
    if (l$$_id_exists != lOther$$_id_exists) {
      return false;
    }
    final l$$_id_gt = $_id_gt;
    final lOther$$_id_gt = other.$_id_gt;
    if (_$data.containsKey('_id_gt') != other._$data.containsKey('_id_gt')) {
      return false;
    }
    if (l$$_id_gt != lOther$$_id_gt) {
      return false;
    }
    final l$$_id_gte = $_id_gte;
    final lOther$$_id_gte = other.$_id_gte;
    if (_$data.containsKey('_id_gte') != other._$data.containsKey('_id_gte')) {
      return false;
    }
    if (l$$_id_gte != lOther$$_id_gte) {
      return false;
    }
    final l$$_id_in = $_id_in;
    final lOther$$_id_in = other.$_id_in;
    if (_$data.containsKey('_id_in') != other._$data.containsKey('_id_in')) {
      return false;
    }
    if (l$$_id_in != null && lOther$$_id_in != null) {
      if (l$$_id_in.length != lOther$$_id_in.length) {
        return false;
      }
      for (int i = 0; i < l$$_id_in.length; i++) {
        final l$$_id_in$entry = l$$_id_in[i];
        final lOther$$_id_in$entry = lOther$$_id_in[i];
        if (l$$_id_in$entry != lOther$$_id_in$entry) {
          return false;
        }
      }
    } else if (l$$_id_in != lOther$$_id_in) {
      return false;
    }
    final l$$_id_lt = $_id_lt;
    final lOther$$_id_lt = other.$_id_lt;
    if (_$data.containsKey('_id_lt') != other._$data.containsKey('_id_lt')) {
      return false;
    }
    if (l$$_id_lt != lOther$$_id_lt) {
      return false;
    }
    final l$$_id_lte = $_id_lte;
    final lOther$$_id_lte = other.$_id_lte;
    if (_$data.containsKey('_id_lte') != other._$data.containsKey('_id_lte')) {
      return false;
    }
    if (l$$_id_lte != lOther$$_id_lte) {
      return false;
    }
    final l$createdAt_eq = createdAt_eq;
    final lOther$createdAt_eq = other.createdAt_eq;
    if (_$data.containsKey('createdAt_eq') !=
        other._$data.containsKey('createdAt_eq')) {
      return false;
    }
    if (l$createdAt_eq != lOther$createdAt_eq) {
      return false;
    }
    final l$createdAt_exists = createdAt_exists;
    final lOther$createdAt_exists = other.createdAt_exists;
    if (_$data.containsKey('createdAt_exists') !=
        other._$data.containsKey('createdAt_exists')) {
      return false;
    }
    if (l$createdAt_exists != lOther$createdAt_exists) {
      return false;
    }
    final l$createdAt_gt = createdAt_gt;
    final lOther$createdAt_gt = other.createdAt_gt;
    if (_$data.containsKey('createdAt_gt') !=
        other._$data.containsKey('createdAt_gt')) {
      return false;
    }
    if (l$createdAt_gt != lOther$createdAt_gt) {
      return false;
    }
    final l$createdAt_gte = createdAt_gte;
    final lOther$createdAt_gte = other.createdAt_gte;
    if (_$data.containsKey('createdAt_gte') !=
        other._$data.containsKey('createdAt_gte')) {
      return false;
    }
    if (l$createdAt_gte != lOther$createdAt_gte) {
      return false;
    }
    final l$createdAt_in = createdAt_in;
    final lOther$createdAt_in = other.createdAt_in;
    if (_$data.containsKey('createdAt_in') !=
        other._$data.containsKey('createdAt_in')) {
      return false;
    }
    if (l$createdAt_in != null && lOther$createdAt_in != null) {
      if (l$createdAt_in.length != lOther$createdAt_in.length) {
        return false;
      }
      for (int i = 0; i < l$createdAt_in.length; i++) {
        final l$createdAt_in$entry = l$createdAt_in[i];
        final lOther$createdAt_in$entry = lOther$createdAt_in[i];
        if (l$createdAt_in$entry != lOther$createdAt_in$entry) {
          return false;
        }
      }
    } else if (l$createdAt_in != lOther$createdAt_in) {
      return false;
    }
    final l$createdAt_lt = createdAt_lt;
    final lOther$createdAt_lt = other.createdAt_lt;
    if (_$data.containsKey('createdAt_lt') !=
        other._$data.containsKey('createdAt_lt')) {
      return false;
    }
    if (l$createdAt_lt != lOther$createdAt_lt) {
      return false;
    }
    final l$createdAt_lte = createdAt_lte;
    final lOther$createdAt_lte = other.createdAt_lte;
    if (_$data.containsKey('createdAt_lte') !=
        other._$data.containsKey('createdAt_lte')) {
      return false;
    }
    if (l$createdAt_lte != lOther$createdAt_lte) {
      return false;
    }
    final l$updatedAt_eq = updatedAt_eq;
    final lOther$updatedAt_eq = other.updatedAt_eq;
    if (_$data.containsKey('updatedAt_eq') !=
        other._$data.containsKey('updatedAt_eq')) {
      return false;
    }
    if (l$updatedAt_eq != lOther$updatedAt_eq) {
      return false;
    }
    final l$updatedAt_exists = updatedAt_exists;
    final lOther$updatedAt_exists = other.updatedAt_exists;
    if (_$data.containsKey('updatedAt_exists') !=
        other._$data.containsKey('updatedAt_exists')) {
      return false;
    }
    if (l$updatedAt_exists != lOther$updatedAt_exists) {
      return false;
    }
    final l$updatedAt_gt = updatedAt_gt;
    final lOther$updatedAt_gt = other.updatedAt_gt;
    if (_$data.containsKey('updatedAt_gt') !=
        other._$data.containsKey('updatedAt_gt')) {
      return false;
    }
    if (l$updatedAt_gt != lOther$updatedAt_gt) {
      return false;
    }
    final l$updatedAt_gte = updatedAt_gte;
    final lOther$updatedAt_gte = other.updatedAt_gte;
    if (_$data.containsKey('updatedAt_gte') !=
        other._$data.containsKey('updatedAt_gte')) {
      return false;
    }
    if (l$updatedAt_gte != lOther$updatedAt_gte) {
      return false;
    }
    final l$updatedAt_in = updatedAt_in;
    final lOther$updatedAt_in = other.updatedAt_in;
    if (_$data.containsKey('updatedAt_in') !=
        other._$data.containsKey('updatedAt_in')) {
      return false;
    }
    if (l$updatedAt_in != null && lOther$updatedAt_in != null) {
      if (l$updatedAt_in.length != lOther$updatedAt_in.length) {
        return false;
      }
      for (int i = 0; i < l$updatedAt_in.length; i++) {
        final l$updatedAt_in$entry = l$updatedAt_in[i];
        final lOther$updatedAt_in$entry = lOther$updatedAt_in[i];
        if (l$updatedAt_in$entry != lOther$updatedAt_in$entry) {
          return false;
        }
      }
    } else if (l$updatedAt_in != lOther$updatedAt_in) {
      return false;
    }
    final l$updatedAt_lt = updatedAt_lt;
    final lOther$updatedAt_lt = other.updatedAt_lt;
    if (_$data.containsKey('updatedAt_lt') !=
        other._$data.containsKey('updatedAt_lt')) {
      return false;
    }
    if (l$updatedAt_lt != lOther$updatedAt_lt) {
      return false;
    }
    final l$updatedAt_lte = updatedAt_lte;
    final lOther$updatedAt_lte = other.updatedAt_lte;
    if (_$data.containsKey('updatedAt_lte') !=
        other._$data.containsKey('updatedAt_lte')) {
      return false;
    }
    if (l$updatedAt_lte != lOther$updatedAt_lte) {
      return false;
    }
    final l$avatar_eq = avatar_eq;
    final lOther$avatar_eq = other.avatar_eq;
    if (_$data.containsKey('avatar_eq') !=
        other._$data.containsKey('avatar_eq')) {
      return false;
    }
    if (l$avatar_eq != lOther$avatar_eq) {
      return false;
    }
    final l$avatar_exists = avatar_exists;
    final lOther$avatar_exists = other.avatar_exists;
    if (_$data.containsKey('avatar_exists') !=
        other._$data.containsKey('avatar_exists')) {
      return false;
    }
    if (l$avatar_exists != lOther$avatar_exists) {
      return false;
    }
    final l$avatar_gt = avatar_gt;
    final lOther$avatar_gt = other.avatar_gt;
    if (_$data.containsKey('avatar_gt') !=
        other._$data.containsKey('avatar_gt')) {
      return false;
    }
    if (l$avatar_gt != lOther$avatar_gt) {
      return false;
    }
    final l$avatar_gte = avatar_gte;
    final lOther$avatar_gte = other.avatar_gte;
    if (_$data.containsKey('avatar_gte') !=
        other._$data.containsKey('avatar_gte')) {
      return false;
    }
    if (l$avatar_gte != lOther$avatar_gte) {
      return false;
    }
    final l$avatar_in = avatar_in;
    final lOther$avatar_in = other.avatar_in;
    if (_$data.containsKey('avatar_in') !=
        other._$data.containsKey('avatar_in')) {
      return false;
    }
    if (l$avatar_in != null && lOther$avatar_in != null) {
      if (l$avatar_in.length != lOther$avatar_in.length) {
        return false;
      }
      for (int i = 0; i < l$avatar_in.length; i++) {
        final l$avatar_in$entry = l$avatar_in[i];
        final lOther$avatar_in$entry = lOther$avatar_in[i];
        if (l$avatar_in$entry != lOther$avatar_in$entry) {
          return false;
        }
      }
    } else if (l$avatar_in != lOther$avatar_in) {
      return false;
    }
    final l$avatar_lt = avatar_lt;
    final lOther$avatar_lt = other.avatar_lt;
    if (_$data.containsKey('avatar_lt') !=
        other._$data.containsKey('avatar_lt')) {
      return false;
    }
    if (l$avatar_lt != lOther$avatar_lt) {
      return false;
    }
    final l$avatar_lte = avatar_lte;
    final lOther$avatar_lte = other.avatar_lte;
    if (_$data.containsKey('avatar_lte') !=
        other._$data.containsKey('avatar_lte')) {
      return false;
    }
    if (l$avatar_lte != lOther$avatar_lte) {
      return false;
    }
    final l$backstory_eq = backstory_eq;
    final lOther$backstory_eq = other.backstory_eq;
    if (_$data.containsKey('backstory_eq') !=
        other._$data.containsKey('backstory_eq')) {
      return false;
    }
    if (l$backstory_eq != lOther$backstory_eq) {
      return false;
    }
    final l$backstory_exists = backstory_exists;
    final lOther$backstory_exists = other.backstory_exists;
    if (_$data.containsKey('backstory_exists') !=
        other._$data.containsKey('backstory_exists')) {
      return false;
    }
    if (l$backstory_exists != lOther$backstory_exists) {
      return false;
    }
    final l$backstory_gt = backstory_gt;
    final lOther$backstory_gt = other.backstory_gt;
    if (_$data.containsKey('backstory_gt') !=
        other._$data.containsKey('backstory_gt')) {
      return false;
    }
    if (l$backstory_gt != lOther$backstory_gt) {
      return false;
    }
    final l$backstory_gte = backstory_gte;
    final lOther$backstory_gte = other.backstory_gte;
    if (_$data.containsKey('backstory_gte') !=
        other._$data.containsKey('backstory_gte')) {
      return false;
    }
    if (l$backstory_gte != lOther$backstory_gte) {
      return false;
    }
    final l$backstory_in = backstory_in;
    final lOther$backstory_in = other.backstory_in;
    if (_$data.containsKey('backstory_in') !=
        other._$data.containsKey('backstory_in')) {
      return false;
    }
    if (l$backstory_in != null && lOther$backstory_in != null) {
      if (l$backstory_in.length != lOther$backstory_in.length) {
        return false;
      }
      for (int i = 0; i < l$backstory_in.length; i++) {
        final l$backstory_in$entry = l$backstory_in[i];
        final lOther$backstory_in$entry = lOther$backstory_in[i];
        if (l$backstory_in$entry != lOther$backstory_in$entry) {
          return false;
        }
      }
    } else if (l$backstory_in != lOther$backstory_in) {
      return false;
    }
    final l$backstory_lt = backstory_lt;
    final lOther$backstory_lt = other.backstory_lt;
    if (_$data.containsKey('backstory_lt') !=
        other._$data.containsKey('backstory_lt')) {
      return false;
    }
    if (l$backstory_lt != lOther$backstory_lt) {
      return false;
    }
    final l$backstory_lte = backstory_lte;
    final lOther$backstory_lte = other.backstory_lte;
    if (_$data.containsKey('backstory_lte') !=
        other._$data.containsKey('backstory_lte')) {
      return false;
    }
    if (l$backstory_lte != lOther$backstory_lte) {
      return false;
    }
    final l$description_eq = description_eq;
    final lOther$description_eq = other.description_eq;
    if (_$data.containsKey('description_eq') !=
        other._$data.containsKey('description_eq')) {
      return false;
    }
    if (l$description_eq != lOther$description_eq) {
      return false;
    }
    final l$description_exists = description_exists;
    final lOther$description_exists = other.description_exists;
    if (_$data.containsKey('description_exists') !=
        other._$data.containsKey('description_exists')) {
      return false;
    }
    if (l$description_exists != lOther$description_exists) {
      return false;
    }
    final l$description_gt = description_gt;
    final lOther$description_gt = other.description_gt;
    if (_$data.containsKey('description_gt') !=
        other._$data.containsKey('description_gt')) {
      return false;
    }
    if (l$description_gt != lOther$description_gt) {
      return false;
    }
    final l$description_gte = description_gte;
    final lOther$description_gte = other.description_gte;
    if (_$data.containsKey('description_gte') !=
        other._$data.containsKey('description_gte')) {
      return false;
    }
    if (l$description_gte != lOther$description_gte) {
      return false;
    }
    final l$description_in = description_in;
    final lOther$description_in = other.description_in;
    if (_$data.containsKey('description_in') !=
        other._$data.containsKey('description_in')) {
      return false;
    }
    if (l$description_in != null && lOther$description_in != null) {
      if (l$description_in.length != lOther$description_in.length) {
        return false;
      }
      for (int i = 0; i < l$description_in.length; i++) {
        final l$description_in$entry = l$description_in[i];
        final lOther$description_in$entry = lOther$description_in[i];
        if (l$description_in$entry != lOther$description_in$entry) {
          return false;
        }
      }
    } else if (l$description_in != lOther$description_in) {
      return false;
    }
    final l$description_lt = description_lt;
    final lOther$description_lt = other.description_lt;
    if (_$data.containsKey('description_lt') !=
        other._$data.containsKey('description_lt')) {
      return false;
    }
    if (l$description_lt != lOther$description_lt) {
      return false;
    }
    final l$description_lte = description_lte;
    final lOther$description_lte = other.description_lte;
    if (_$data.containsKey('description_lte') !=
        other._$data.containsKey('description_lte')) {
      return false;
    }
    if (l$description_lte != lOther$description_lte) {
      return false;
    }
    final l$filter_eq = filter_eq;
    final lOther$filter_eq = other.filter_eq;
    if (_$data.containsKey('filter_eq') !=
        other._$data.containsKey('filter_eq')) {
      return false;
    }
    if (l$filter_eq != lOther$filter_eq) {
      return false;
    }
    final l$filter_exists = filter_exists;
    final lOther$filter_exists = other.filter_exists;
    if (_$data.containsKey('filter_exists') !=
        other._$data.containsKey('filter_exists')) {
      return false;
    }
    if (l$filter_exists != lOther$filter_exists) {
      return false;
    }
    final l$filter_gt = filter_gt;
    final lOther$filter_gt = other.filter_gt;
    if (_$data.containsKey('filter_gt') !=
        other._$data.containsKey('filter_gt')) {
      return false;
    }
    if (l$filter_gt != lOther$filter_gt) {
      return false;
    }
    final l$filter_gte = filter_gte;
    final lOther$filter_gte = other.filter_gte;
    if (_$data.containsKey('filter_gte') !=
        other._$data.containsKey('filter_gte')) {
      return false;
    }
    if (l$filter_gte != lOther$filter_gte) {
      return false;
    }
    final l$filter_in = filter_in;
    final lOther$filter_in = other.filter_in;
    if (_$data.containsKey('filter_in') !=
        other._$data.containsKey('filter_in')) {
      return false;
    }
    if (l$filter_in != null && lOther$filter_in != null) {
      if (l$filter_in.length != lOther$filter_in.length) {
        return false;
      }
      for (int i = 0; i < l$filter_in.length; i++) {
        final l$filter_in$entry = l$filter_in[i];
        final lOther$filter_in$entry = lOther$filter_in[i];
        if (l$filter_in$entry != lOther$filter_in$entry) {
          return false;
        }
      }
    } else if (l$filter_in != lOther$filter_in) {
      return false;
    }
    final l$filter_lt = filter_lt;
    final lOther$filter_lt = other.filter_lt;
    if (_$data.containsKey('filter_lt') !=
        other._$data.containsKey('filter_lt')) {
      return false;
    }
    if (l$filter_lt != lOther$filter_lt) {
      return false;
    }
    final l$filter_lte = filter_lte;
    final lOther$filter_lte = other.filter_lte;
    if (_$data.containsKey('filter_lte') !=
        other._$data.containsKey('filter_lte')) {
      return false;
    }
    if (l$filter_lte != lOther$filter_lte) {
      return false;
    }
    final l$isPublic_eq = isPublic_eq;
    final lOther$isPublic_eq = other.isPublic_eq;
    if (_$data.containsKey('isPublic_eq') !=
        other._$data.containsKey('isPublic_eq')) {
      return false;
    }
    if (l$isPublic_eq != lOther$isPublic_eq) {
      return false;
    }
    final l$isPublic_exists = isPublic_exists;
    final lOther$isPublic_exists = other.isPublic_exists;
    if (_$data.containsKey('isPublic_exists') !=
        other._$data.containsKey('isPublic_exists')) {
      return false;
    }
    if (l$isPublic_exists != lOther$isPublic_exists) {
      return false;
    }
    final l$isPublic_gt = isPublic_gt;
    final lOther$isPublic_gt = other.isPublic_gt;
    if (_$data.containsKey('isPublic_gt') !=
        other._$data.containsKey('isPublic_gt')) {
      return false;
    }
    if (l$isPublic_gt != lOther$isPublic_gt) {
      return false;
    }
    final l$isPublic_gte = isPublic_gte;
    final lOther$isPublic_gte = other.isPublic_gte;
    if (_$data.containsKey('isPublic_gte') !=
        other._$data.containsKey('isPublic_gte')) {
      return false;
    }
    if (l$isPublic_gte != lOther$isPublic_gte) {
      return false;
    }
    final l$isPublic_in = isPublic_in;
    final lOther$isPublic_in = other.isPublic_in;
    if (_$data.containsKey('isPublic_in') !=
        other._$data.containsKey('isPublic_in')) {
      return false;
    }
    if (l$isPublic_in != null && lOther$isPublic_in != null) {
      if (l$isPublic_in.length != lOther$isPublic_in.length) {
        return false;
      }
      for (int i = 0; i < l$isPublic_in.length; i++) {
        final l$isPublic_in$entry = l$isPublic_in[i];
        final lOther$isPublic_in$entry = lOther$isPublic_in[i];
        if (l$isPublic_in$entry != lOther$isPublic_in$entry) {
          return false;
        }
      }
    } else if (l$isPublic_in != lOther$isPublic_in) {
      return false;
    }
    final l$isPublic_lt = isPublic_lt;
    final lOther$isPublic_lt = other.isPublic_lt;
    if (_$data.containsKey('isPublic_lt') !=
        other._$data.containsKey('isPublic_lt')) {
      return false;
    }
    if (l$isPublic_lt != lOther$isPublic_lt) {
      return false;
    }
    final l$isPublic_lte = isPublic_lte;
    final lOther$isPublic_lte = other.isPublic_lte;
    if (_$data.containsKey('isPublic_lte') !=
        other._$data.containsKey('isPublic_lte')) {
      return false;
    }
    if (l$isPublic_lte != lOther$isPublic_lte) {
      return false;
    }
    final l$job_eq = job_eq;
    final lOther$job_eq = other.job_eq;
    if (_$data.containsKey('job_eq') != other._$data.containsKey('job_eq')) {
      return false;
    }
    if (l$job_eq != lOther$job_eq) {
      return false;
    }
    final l$job_exists = job_exists;
    final lOther$job_exists = other.job_exists;
    if (_$data.containsKey('job_exists') !=
        other._$data.containsKey('job_exists')) {
      return false;
    }
    if (l$job_exists != lOther$job_exists) {
      return false;
    }
    final l$job_gt = job_gt;
    final lOther$job_gt = other.job_gt;
    if (_$data.containsKey('job_gt') != other._$data.containsKey('job_gt')) {
      return false;
    }
    if (l$job_gt != lOther$job_gt) {
      return false;
    }
    final l$job_gte = job_gte;
    final lOther$job_gte = other.job_gte;
    if (_$data.containsKey('job_gte') != other._$data.containsKey('job_gte')) {
      return false;
    }
    if (l$job_gte != lOther$job_gte) {
      return false;
    }
    final l$job_in = job_in;
    final lOther$job_in = other.job_in;
    if (_$data.containsKey('job_in') != other._$data.containsKey('job_in')) {
      return false;
    }
    if (l$job_in != null && lOther$job_in != null) {
      if (l$job_in.length != lOther$job_in.length) {
        return false;
      }
      for (int i = 0; i < l$job_in.length; i++) {
        final l$job_in$entry = l$job_in[i];
        final lOther$job_in$entry = lOther$job_in[i];
        if (l$job_in$entry != lOther$job_in$entry) {
          return false;
        }
      }
    } else if (l$job_in != lOther$job_in) {
      return false;
    }
    final l$job_lt = job_lt;
    final lOther$job_lt = other.job_lt;
    if (_$data.containsKey('job_lt') != other._$data.containsKey('job_lt')) {
      return false;
    }
    if (l$job_lt != lOther$job_lt) {
      return false;
    }
    final l$job_lte = job_lte;
    final lOther$job_lte = other.job_lte;
    if (_$data.containsKey('job_lte') != other._$data.containsKey('job_lte')) {
      return false;
    }
    if (l$job_lte != lOther$job_lte) {
      return false;
    }
    final l$modelName_eq = modelName_eq;
    final lOther$modelName_eq = other.modelName_eq;
    if (_$data.containsKey('modelName_eq') !=
        other._$data.containsKey('modelName_eq')) {
      return false;
    }
    if (l$modelName_eq != lOther$modelName_eq) {
      return false;
    }
    final l$modelName_exists = modelName_exists;
    final lOther$modelName_exists = other.modelName_exists;
    if (_$data.containsKey('modelName_exists') !=
        other._$data.containsKey('modelName_exists')) {
      return false;
    }
    if (l$modelName_exists != lOther$modelName_exists) {
      return false;
    }
    final l$modelName_gt = modelName_gt;
    final lOther$modelName_gt = other.modelName_gt;
    if (_$data.containsKey('modelName_gt') !=
        other._$data.containsKey('modelName_gt')) {
      return false;
    }
    if (l$modelName_gt != lOther$modelName_gt) {
      return false;
    }
    final l$modelName_gte = modelName_gte;
    final lOther$modelName_gte = other.modelName_gte;
    if (_$data.containsKey('modelName_gte') !=
        other._$data.containsKey('modelName_gte')) {
      return false;
    }
    if (l$modelName_gte != lOther$modelName_gte) {
      return false;
    }
    final l$modelName_in = modelName_in;
    final lOther$modelName_in = other.modelName_in;
    if (_$data.containsKey('modelName_in') !=
        other._$data.containsKey('modelName_in')) {
      return false;
    }
    if (l$modelName_in != null && lOther$modelName_in != null) {
      if (l$modelName_in.length != lOther$modelName_in.length) {
        return false;
      }
      for (int i = 0; i < l$modelName_in.length; i++) {
        final l$modelName_in$entry = l$modelName_in[i];
        final lOther$modelName_in$entry = lOther$modelName_in[i];
        if (l$modelName_in$entry != lOther$modelName_in$entry) {
          return false;
        }
      }
    } else if (l$modelName_in != lOther$modelName_in) {
      return false;
    }
    final l$modelName_lt = modelName_lt;
    final lOther$modelName_lt = other.modelName_lt;
    if (_$data.containsKey('modelName_lt') !=
        other._$data.containsKey('modelName_lt')) {
      return false;
    }
    if (l$modelName_lt != lOther$modelName_lt) {
      return false;
    }
    final l$modelName_lte = modelName_lte;
    final lOther$modelName_lte = other.modelName_lte;
    if (_$data.containsKey('modelName_lte') !=
        other._$data.containsKey('modelName_lte')) {
      return false;
    }
    if (l$modelName_lte != lOther$modelName_lte) {
      return false;
    }
    final l$name_eq = name_eq;
    final lOther$name_eq = other.name_eq;
    if (_$data.containsKey('name_eq') != other._$data.containsKey('name_eq')) {
      return false;
    }
    if (l$name_eq != lOther$name_eq) {
      return false;
    }
    final l$name_exists = name_exists;
    final lOther$name_exists = other.name_exists;
    if (_$data.containsKey('name_exists') !=
        other._$data.containsKey('name_exists')) {
      return false;
    }
    if (l$name_exists != lOther$name_exists) {
      return false;
    }
    final l$name_gt = name_gt;
    final lOther$name_gt = other.name_gt;
    if (_$data.containsKey('name_gt') != other._$data.containsKey('name_gt')) {
      return false;
    }
    if (l$name_gt != lOther$name_gt) {
      return false;
    }
    final l$name_gte = name_gte;
    final lOther$name_gte = other.name_gte;
    if (_$data.containsKey('name_gte') !=
        other._$data.containsKey('name_gte')) {
      return false;
    }
    if (l$name_gte != lOther$name_gte) {
      return false;
    }
    final l$name_in = name_in;
    final lOther$name_in = other.name_in;
    if (_$data.containsKey('name_in') != other._$data.containsKey('name_in')) {
      return false;
    }
    if (l$name_in != null && lOther$name_in != null) {
      if (l$name_in.length != lOther$name_in.length) {
        return false;
      }
      for (int i = 0; i < l$name_in.length; i++) {
        final l$name_in$entry = l$name_in[i];
        final lOther$name_in$entry = lOther$name_in[i];
        if (l$name_in$entry != lOther$name_in$entry) {
          return false;
        }
      }
    } else if (l$name_in != lOther$name_in) {
      return false;
    }
    final l$name_lt = name_lt;
    final lOther$name_lt = other.name_lt;
    if (_$data.containsKey('name_lt') != other._$data.containsKey('name_lt')) {
      return false;
    }
    if (l$name_lt != lOther$name_lt) {
      return false;
    }
    final l$name_lte = name_lte;
    final lOther$name_lte = other.name_lte;
    if (_$data.containsKey('name_lte') !=
        other._$data.containsKey('name_lte')) {
      return false;
    }
    if (l$name_lte != lOther$name_lte) {
      return false;
    }
    final l$openaiApiKey_eq = openaiApiKey_eq;
    final lOther$openaiApiKey_eq = other.openaiApiKey_eq;
    if (_$data.containsKey('openaiApiKey_eq') !=
        other._$data.containsKey('openaiApiKey_eq')) {
      return false;
    }
    if (l$openaiApiKey_eq != lOther$openaiApiKey_eq) {
      return false;
    }
    final l$openaiApiKey_exists = openaiApiKey_exists;
    final lOther$openaiApiKey_exists = other.openaiApiKey_exists;
    if (_$data.containsKey('openaiApiKey_exists') !=
        other._$data.containsKey('openaiApiKey_exists')) {
      return false;
    }
    if (l$openaiApiKey_exists != lOther$openaiApiKey_exists) {
      return false;
    }
    final l$openaiApiKey_gt = openaiApiKey_gt;
    final lOther$openaiApiKey_gt = other.openaiApiKey_gt;
    if (_$data.containsKey('openaiApiKey_gt') !=
        other._$data.containsKey('openaiApiKey_gt')) {
      return false;
    }
    if (l$openaiApiKey_gt != lOther$openaiApiKey_gt) {
      return false;
    }
    final l$openaiApiKey_gte = openaiApiKey_gte;
    final lOther$openaiApiKey_gte = other.openaiApiKey_gte;
    if (_$data.containsKey('openaiApiKey_gte') !=
        other._$data.containsKey('openaiApiKey_gte')) {
      return false;
    }
    if (l$openaiApiKey_gte != lOther$openaiApiKey_gte) {
      return false;
    }
    final l$openaiApiKey_in = openaiApiKey_in;
    final lOther$openaiApiKey_in = other.openaiApiKey_in;
    if (_$data.containsKey('openaiApiKey_in') !=
        other._$data.containsKey('openaiApiKey_in')) {
      return false;
    }
    if (l$openaiApiKey_in != null && lOther$openaiApiKey_in != null) {
      if (l$openaiApiKey_in.length != lOther$openaiApiKey_in.length) {
        return false;
      }
      for (int i = 0; i < l$openaiApiKey_in.length; i++) {
        final l$openaiApiKey_in$entry = l$openaiApiKey_in[i];
        final lOther$openaiApiKey_in$entry = lOther$openaiApiKey_in[i];
        if (l$openaiApiKey_in$entry != lOther$openaiApiKey_in$entry) {
          return false;
        }
      }
    } else if (l$openaiApiKey_in != lOther$openaiApiKey_in) {
      return false;
    }
    final l$openaiApiKey_lt = openaiApiKey_lt;
    final lOther$openaiApiKey_lt = other.openaiApiKey_lt;
    if (_$data.containsKey('openaiApiKey_lt') !=
        other._$data.containsKey('openaiApiKey_lt')) {
      return false;
    }
    if (l$openaiApiKey_lt != lOther$openaiApiKey_lt) {
      return false;
    }
    final l$openaiApiKey_lte = openaiApiKey_lte;
    final lOther$openaiApiKey_lte = other.openaiApiKey_lte;
    if (_$data.containsKey('openaiApiKey_lte') !=
        other._$data.containsKey('openaiApiKey_lte')) {
      return false;
    }
    if (l$openaiApiKey_lte != lOther$openaiApiKey_lte) {
      return false;
    }
    final l$systemMessage_eq = systemMessage_eq;
    final lOther$systemMessage_eq = other.systemMessage_eq;
    if (_$data.containsKey('systemMessage_eq') !=
        other._$data.containsKey('systemMessage_eq')) {
      return false;
    }
    if (l$systemMessage_eq != lOther$systemMessage_eq) {
      return false;
    }
    final l$systemMessage_exists = systemMessage_exists;
    final lOther$systemMessage_exists = other.systemMessage_exists;
    if (_$data.containsKey('systemMessage_exists') !=
        other._$data.containsKey('systemMessage_exists')) {
      return false;
    }
    if (l$systemMessage_exists != lOther$systemMessage_exists) {
      return false;
    }
    final l$systemMessage_gt = systemMessage_gt;
    final lOther$systemMessage_gt = other.systemMessage_gt;
    if (_$data.containsKey('systemMessage_gt') !=
        other._$data.containsKey('systemMessage_gt')) {
      return false;
    }
    if (l$systemMessage_gt != lOther$systemMessage_gt) {
      return false;
    }
    final l$systemMessage_gte = systemMessage_gte;
    final lOther$systemMessage_gte = other.systemMessage_gte;
    if (_$data.containsKey('systemMessage_gte') !=
        other._$data.containsKey('systemMessage_gte')) {
      return false;
    }
    if (l$systemMessage_gte != lOther$systemMessage_gte) {
      return false;
    }
    final l$systemMessage_in = systemMessage_in;
    final lOther$systemMessage_in = other.systemMessage_in;
    if (_$data.containsKey('systemMessage_in') !=
        other._$data.containsKey('systemMessage_in')) {
      return false;
    }
    if (l$systemMessage_in != null && lOther$systemMessage_in != null) {
      if (l$systemMessage_in.length != lOther$systemMessage_in.length) {
        return false;
      }
      for (int i = 0; i < l$systemMessage_in.length; i++) {
        final l$systemMessage_in$entry = l$systemMessage_in[i];
        final lOther$systemMessage_in$entry = lOther$systemMessage_in[i];
        if (l$systemMessage_in$entry != lOther$systemMessage_in$entry) {
          return false;
        }
      }
    } else if (l$systemMessage_in != lOther$systemMessage_in) {
      return false;
    }
    final l$systemMessage_lt = systemMessage_lt;
    final lOther$systemMessage_lt = other.systemMessage_lt;
    if (_$data.containsKey('systemMessage_lt') !=
        other._$data.containsKey('systemMessage_lt')) {
      return false;
    }
    if (l$systemMessage_lt != lOther$systemMessage_lt) {
      return false;
    }
    final l$systemMessage_lte = systemMessage_lte;
    final lOther$systemMessage_lte = other.systemMessage_lte;
    if (_$data.containsKey('systemMessage_lte') !=
        other._$data.containsKey('systemMessage_lte')) {
      return false;
    }
    if (l$systemMessage_lte != lOther$systemMessage_lte) {
      return false;
    }
    final l$temperature_eq = temperature_eq;
    final lOther$temperature_eq = other.temperature_eq;
    if (_$data.containsKey('temperature_eq') !=
        other._$data.containsKey('temperature_eq')) {
      return false;
    }
    if (l$temperature_eq != lOther$temperature_eq) {
      return false;
    }
    final l$temperature_exists = temperature_exists;
    final lOther$temperature_exists = other.temperature_exists;
    if (_$data.containsKey('temperature_exists') !=
        other._$data.containsKey('temperature_exists')) {
      return false;
    }
    if (l$temperature_exists != lOther$temperature_exists) {
      return false;
    }
    final l$temperature_gt = temperature_gt;
    final lOther$temperature_gt = other.temperature_gt;
    if (_$data.containsKey('temperature_gt') !=
        other._$data.containsKey('temperature_gt')) {
      return false;
    }
    if (l$temperature_gt != lOther$temperature_gt) {
      return false;
    }
    final l$temperature_gte = temperature_gte;
    final lOther$temperature_gte = other.temperature_gte;
    if (_$data.containsKey('temperature_gte') !=
        other._$data.containsKey('temperature_gte')) {
      return false;
    }
    if (l$temperature_gte != lOther$temperature_gte) {
      return false;
    }
    final l$temperature_in = temperature_in;
    final lOther$temperature_in = other.temperature_in;
    if (_$data.containsKey('temperature_in') !=
        other._$data.containsKey('temperature_in')) {
      return false;
    }
    if (l$temperature_in != null && lOther$temperature_in != null) {
      if (l$temperature_in.length != lOther$temperature_in.length) {
        return false;
      }
      for (int i = 0; i < l$temperature_in.length; i++) {
        final l$temperature_in$entry = l$temperature_in[i];
        final lOther$temperature_in$entry = lOther$temperature_in[i];
        if (l$temperature_in$entry != lOther$temperature_in$entry) {
          return false;
        }
      }
    } else if (l$temperature_in != lOther$temperature_in) {
      return false;
    }
    final l$temperature_lt = temperature_lt;
    final lOther$temperature_lt = other.temperature_lt;
    if (_$data.containsKey('temperature_lt') !=
        other._$data.containsKey('temperature_lt')) {
      return false;
    }
    if (l$temperature_lt != lOther$temperature_lt) {
      return false;
    }
    final l$temperature_lte = temperature_lte;
    final lOther$temperature_lte = other.temperature_lte;
    if (_$data.containsKey('temperature_lte') !=
        other._$data.containsKey('temperature_lte')) {
      return false;
    }
    if (l$temperature_lte != lOther$temperature_lte) {
      return false;
    }
    final l$topP_eq = topP_eq;
    final lOther$topP_eq = other.topP_eq;
    if (_$data.containsKey('topP_eq') != other._$data.containsKey('topP_eq')) {
      return false;
    }
    if (l$topP_eq != lOther$topP_eq) {
      return false;
    }
    final l$topP_exists = topP_exists;
    final lOther$topP_exists = other.topP_exists;
    if (_$data.containsKey('topP_exists') !=
        other._$data.containsKey('topP_exists')) {
      return false;
    }
    if (l$topP_exists != lOther$topP_exists) {
      return false;
    }
    final l$topP_gt = topP_gt;
    final lOther$topP_gt = other.topP_gt;
    if (_$data.containsKey('topP_gt') != other._$data.containsKey('topP_gt')) {
      return false;
    }
    if (l$topP_gt != lOther$topP_gt) {
      return false;
    }
    final l$topP_gte = topP_gte;
    final lOther$topP_gte = other.topP_gte;
    if (_$data.containsKey('topP_gte') !=
        other._$data.containsKey('topP_gte')) {
      return false;
    }
    if (l$topP_gte != lOther$topP_gte) {
      return false;
    }
    final l$topP_in = topP_in;
    final lOther$topP_in = other.topP_in;
    if (_$data.containsKey('topP_in') != other._$data.containsKey('topP_in')) {
      return false;
    }
    if (l$topP_in != null && lOther$topP_in != null) {
      if (l$topP_in.length != lOther$topP_in.length) {
        return false;
      }
      for (int i = 0; i < l$topP_in.length; i++) {
        final l$topP_in$entry = l$topP_in[i];
        final lOther$topP_in$entry = lOther$topP_in[i];
        if (l$topP_in$entry != lOther$topP_in$entry) {
          return false;
        }
      }
    } else if (l$topP_in != lOther$topP_in) {
      return false;
    }
    final l$topP_lt = topP_lt;
    final lOther$topP_lt = other.topP_lt;
    if (_$data.containsKey('topP_lt') != other._$data.containsKey('topP_lt')) {
      return false;
    }
    if (l$topP_lt != lOther$topP_lt) {
      return false;
    }
    final l$topP_lte = topP_lte;
    final lOther$topP_lte = other.topP_lte;
    if (_$data.containsKey('topP_lte') !=
        other._$data.containsKey('topP_lte')) {
      return false;
    }
    if (l$topP_lte != lOther$topP_lte) {
      return false;
    }
    final l$user_eq = user_eq;
    final lOther$user_eq = other.user_eq;
    if (_$data.containsKey('user_eq') != other._$data.containsKey('user_eq')) {
      return false;
    }
    if (l$user_eq != lOther$user_eq) {
      return false;
    }
    final l$user_exists = user_exists;
    final lOther$user_exists = other.user_exists;
    if (_$data.containsKey('user_exists') !=
        other._$data.containsKey('user_exists')) {
      return false;
    }
    if (l$user_exists != lOther$user_exists) {
      return false;
    }
    final l$user_gt = user_gt;
    final lOther$user_gt = other.user_gt;
    if (_$data.containsKey('user_gt') != other._$data.containsKey('user_gt')) {
      return false;
    }
    if (l$user_gt != lOther$user_gt) {
      return false;
    }
    final l$user_gte = user_gte;
    final lOther$user_gte = other.user_gte;
    if (_$data.containsKey('user_gte') !=
        other._$data.containsKey('user_gte')) {
      return false;
    }
    if (l$user_gte != lOther$user_gte) {
      return false;
    }
    final l$user_in = user_in;
    final lOther$user_in = other.user_in;
    if (_$data.containsKey('user_in') != other._$data.containsKey('user_in')) {
      return false;
    }
    if (l$user_in != null && lOther$user_in != null) {
      if (l$user_in.length != lOther$user_in.length) {
        return false;
      }
      for (int i = 0; i < l$user_in.length; i++) {
        final l$user_in$entry = l$user_in[i];
        final lOther$user_in$entry = lOther$user_in[i];
        if (l$user_in$entry != lOther$user_in$entry) {
          return false;
        }
      }
    } else if (l$user_in != lOther$user_in) {
      return false;
    }
    final l$user_lt = user_lt;
    final lOther$user_lt = other.user_lt;
    if (_$data.containsKey('user_lt') != other._$data.containsKey('user_lt')) {
      return false;
    }
    if (l$user_lt != lOther$user_lt) {
      return false;
    }
    final l$user_lte = user_lte;
    final lOther$user_lte = other.user_lte;
    if (_$data.containsKey('user_lte') !=
        other._$data.containsKey('user_lte')) {
      return false;
    }
    if (l$user_lte != lOther$user_lte) {
      return false;
    }
    final l$welcomeMessage_eq = welcomeMessage_eq;
    final lOther$welcomeMessage_eq = other.welcomeMessage_eq;
    if (_$data.containsKey('welcomeMessage_eq') !=
        other._$data.containsKey('welcomeMessage_eq')) {
      return false;
    }
    if (l$welcomeMessage_eq != lOther$welcomeMessage_eq) {
      return false;
    }
    final l$welcomeMessage_exists = welcomeMessage_exists;
    final lOther$welcomeMessage_exists = other.welcomeMessage_exists;
    if (_$data.containsKey('welcomeMessage_exists') !=
        other._$data.containsKey('welcomeMessage_exists')) {
      return false;
    }
    if (l$welcomeMessage_exists != lOther$welcomeMessage_exists) {
      return false;
    }
    final l$welcomeMessage_gt = welcomeMessage_gt;
    final lOther$welcomeMessage_gt = other.welcomeMessage_gt;
    if (_$data.containsKey('welcomeMessage_gt') !=
        other._$data.containsKey('welcomeMessage_gt')) {
      return false;
    }
    if (l$welcomeMessage_gt != lOther$welcomeMessage_gt) {
      return false;
    }
    final l$welcomeMessage_gte = welcomeMessage_gte;
    final lOther$welcomeMessage_gte = other.welcomeMessage_gte;
    if (_$data.containsKey('welcomeMessage_gte') !=
        other._$data.containsKey('welcomeMessage_gte')) {
      return false;
    }
    if (l$welcomeMessage_gte != lOther$welcomeMessage_gte) {
      return false;
    }
    final l$welcomeMessage_in = welcomeMessage_in;
    final lOther$welcomeMessage_in = other.welcomeMessage_in;
    if (_$data.containsKey('welcomeMessage_in') !=
        other._$data.containsKey('welcomeMessage_in')) {
      return false;
    }
    if (l$welcomeMessage_in != null && lOther$welcomeMessage_in != null) {
      if (l$welcomeMessage_in.length != lOther$welcomeMessage_in.length) {
        return false;
      }
      for (int i = 0; i < l$welcomeMessage_in.length; i++) {
        final l$welcomeMessage_in$entry = l$welcomeMessage_in[i];
        final lOther$welcomeMessage_in$entry = lOther$welcomeMessage_in[i];
        if (l$welcomeMessage_in$entry != lOther$welcomeMessage_in$entry) {
          return false;
        }
      }
    } else if (l$welcomeMessage_in != lOther$welcomeMessage_in) {
      return false;
    }
    final l$welcomeMessage_lt = welcomeMessage_lt;
    final lOther$welcomeMessage_lt = other.welcomeMessage_lt;
    if (_$data.containsKey('welcomeMessage_lt') !=
        other._$data.containsKey('welcomeMessage_lt')) {
      return false;
    }
    if (l$welcomeMessage_lt != lOther$welcomeMessage_lt) {
      return false;
    }
    final l$welcomeMessage_lte = welcomeMessage_lte;
    final lOther$welcomeMessage_lte = other.welcomeMessage_lte;
    if (_$data.containsKey('welcomeMessage_lte') !=
        other._$data.containsKey('welcomeMessage_lte')) {
      return false;
    }
    if (l$welcomeMessage_lte != lOther$welcomeMessage_lte) {
      return false;
    }
    final l$welcomeMetadata_eq = welcomeMetadata_eq;
    final lOther$welcomeMetadata_eq = other.welcomeMetadata_eq;
    if (_$data.containsKey('welcomeMetadata_eq') !=
        other._$data.containsKey('welcomeMetadata_eq')) {
      return false;
    }
    if (l$welcomeMetadata_eq != lOther$welcomeMetadata_eq) {
      return false;
    }
    final l$welcomeMetadata_exists = welcomeMetadata_exists;
    final lOther$welcomeMetadata_exists = other.welcomeMetadata_exists;
    if (_$data.containsKey('welcomeMetadata_exists') !=
        other._$data.containsKey('welcomeMetadata_exists')) {
      return false;
    }
    if (l$welcomeMetadata_exists != lOther$welcomeMetadata_exists) {
      return false;
    }
    final l$welcomeMetadata_gt = welcomeMetadata_gt;
    final lOther$welcomeMetadata_gt = other.welcomeMetadata_gt;
    if (_$data.containsKey('welcomeMetadata_gt') !=
        other._$data.containsKey('welcomeMetadata_gt')) {
      return false;
    }
    if (l$welcomeMetadata_gt != lOther$welcomeMetadata_gt) {
      return false;
    }
    final l$welcomeMetadata_gte = welcomeMetadata_gte;
    final lOther$welcomeMetadata_gte = other.welcomeMetadata_gte;
    if (_$data.containsKey('welcomeMetadata_gte') !=
        other._$data.containsKey('welcomeMetadata_gte')) {
      return false;
    }
    if (l$welcomeMetadata_gte != lOther$welcomeMetadata_gte) {
      return false;
    }
    final l$welcomeMetadata_in = welcomeMetadata_in;
    final lOther$welcomeMetadata_in = other.welcomeMetadata_in;
    if (_$data.containsKey('welcomeMetadata_in') !=
        other._$data.containsKey('welcomeMetadata_in')) {
      return false;
    }
    if (l$welcomeMetadata_in != null && lOther$welcomeMetadata_in != null) {
      if (l$welcomeMetadata_in.length != lOther$welcomeMetadata_in.length) {
        return false;
      }
      for (int i = 0; i < l$welcomeMetadata_in.length; i++) {
        final l$welcomeMetadata_in$entry = l$welcomeMetadata_in[i];
        final lOther$welcomeMetadata_in$entry = lOther$welcomeMetadata_in[i];
        if (l$welcomeMetadata_in$entry != lOther$welcomeMetadata_in$entry) {
          return false;
        }
      }
    } else if (l$welcomeMetadata_in != lOther$welcomeMetadata_in) {
      return false;
    }
    final l$welcomeMetadata_lt = welcomeMetadata_lt;
    final lOther$welcomeMetadata_lt = other.welcomeMetadata_lt;
    if (_$data.containsKey('welcomeMetadata_lt') !=
        other._$data.containsKey('welcomeMetadata_lt')) {
      return false;
    }
    if (l$welcomeMetadata_lt != lOther$welcomeMetadata_lt) {
      return false;
    }
    final l$welcomeMetadata_lte = welcomeMetadata_lte;
    final lOther$welcomeMetadata_lte = other.welcomeMetadata_lte;
    if (_$data.containsKey('welcomeMetadata_lte') !=
        other._$data.containsKey('welcomeMetadata_lte')) {
      return false;
    }
    if (l$welcomeMetadata_lte != lOther$welcomeMetadata_lte) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$$_id_eq = $_id_eq;
    final l$$_id_exists = $_id_exists;
    final l$$_id_gt = $_id_gt;
    final l$$_id_gte = $_id_gte;
    final l$$_id_in = $_id_in;
    final l$$_id_lt = $_id_lt;
    final l$$_id_lte = $_id_lte;
    final l$createdAt_eq = createdAt_eq;
    final l$createdAt_exists = createdAt_exists;
    final l$createdAt_gt = createdAt_gt;
    final l$createdAt_gte = createdAt_gte;
    final l$createdAt_in = createdAt_in;
    final l$createdAt_lt = createdAt_lt;
    final l$createdAt_lte = createdAt_lte;
    final l$updatedAt_eq = updatedAt_eq;
    final l$updatedAt_exists = updatedAt_exists;
    final l$updatedAt_gt = updatedAt_gt;
    final l$updatedAt_gte = updatedAt_gte;
    final l$updatedAt_in = updatedAt_in;
    final l$updatedAt_lt = updatedAt_lt;
    final l$updatedAt_lte = updatedAt_lte;
    final l$avatar_eq = avatar_eq;
    final l$avatar_exists = avatar_exists;
    final l$avatar_gt = avatar_gt;
    final l$avatar_gte = avatar_gte;
    final l$avatar_in = avatar_in;
    final l$avatar_lt = avatar_lt;
    final l$avatar_lte = avatar_lte;
    final l$backstory_eq = backstory_eq;
    final l$backstory_exists = backstory_exists;
    final l$backstory_gt = backstory_gt;
    final l$backstory_gte = backstory_gte;
    final l$backstory_in = backstory_in;
    final l$backstory_lt = backstory_lt;
    final l$backstory_lte = backstory_lte;
    final l$description_eq = description_eq;
    final l$description_exists = description_exists;
    final l$description_gt = description_gt;
    final l$description_gte = description_gte;
    final l$description_in = description_in;
    final l$description_lt = description_lt;
    final l$description_lte = description_lte;
    final l$filter_eq = filter_eq;
    final l$filter_exists = filter_exists;
    final l$filter_gt = filter_gt;
    final l$filter_gte = filter_gte;
    final l$filter_in = filter_in;
    final l$filter_lt = filter_lt;
    final l$filter_lte = filter_lte;
    final l$isPublic_eq = isPublic_eq;
    final l$isPublic_exists = isPublic_exists;
    final l$isPublic_gt = isPublic_gt;
    final l$isPublic_gte = isPublic_gte;
    final l$isPublic_in = isPublic_in;
    final l$isPublic_lt = isPublic_lt;
    final l$isPublic_lte = isPublic_lte;
    final l$job_eq = job_eq;
    final l$job_exists = job_exists;
    final l$job_gt = job_gt;
    final l$job_gte = job_gte;
    final l$job_in = job_in;
    final l$job_lt = job_lt;
    final l$job_lte = job_lte;
    final l$modelName_eq = modelName_eq;
    final l$modelName_exists = modelName_exists;
    final l$modelName_gt = modelName_gt;
    final l$modelName_gte = modelName_gte;
    final l$modelName_in = modelName_in;
    final l$modelName_lt = modelName_lt;
    final l$modelName_lte = modelName_lte;
    final l$name_eq = name_eq;
    final l$name_exists = name_exists;
    final l$name_gt = name_gt;
    final l$name_gte = name_gte;
    final l$name_in = name_in;
    final l$name_lt = name_lt;
    final l$name_lte = name_lte;
    final l$openaiApiKey_eq = openaiApiKey_eq;
    final l$openaiApiKey_exists = openaiApiKey_exists;
    final l$openaiApiKey_gt = openaiApiKey_gt;
    final l$openaiApiKey_gte = openaiApiKey_gte;
    final l$openaiApiKey_in = openaiApiKey_in;
    final l$openaiApiKey_lt = openaiApiKey_lt;
    final l$openaiApiKey_lte = openaiApiKey_lte;
    final l$systemMessage_eq = systemMessage_eq;
    final l$systemMessage_exists = systemMessage_exists;
    final l$systemMessage_gt = systemMessage_gt;
    final l$systemMessage_gte = systemMessage_gte;
    final l$systemMessage_in = systemMessage_in;
    final l$systemMessage_lt = systemMessage_lt;
    final l$systemMessage_lte = systemMessage_lte;
    final l$temperature_eq = temperature_eq;
    final l$temperature_exists = temperature_exists;
    final l$temperature_gt = temperature_gt;
    final l$temperature_gte = temperature_gte;
    final l$temperature_in = temperature_in;
    final l$temperature_lt = temperature_lt;
    final l$temperature_lte = temperature_lte;
    final l$topP_eq = topP_eq;
    final l$topP_exists = topP_exists;
    final l$topP_gt = topP_gt;
    final l$topP_gte = topP_gte;
    final l$topP_in = topP_in;
    final l$topP_lt = topP_lt;
    final l$topP_lte = topP_lte;
    final l$user_eq = user_eq;
    final l$user_exists = user_exists;
    final l$user_gt = user_gt;
    final l$user_gte = user_gte;
    final l$user_in = user_in;
    final l$user_lt = user_lt;
    final l$user_lte = user_lte;
    final l$welcomeMessage_eq = welcomeMessage_eq;
    final l$welcomeMessage_exists = welcomeMessage_exists;
    final l$welcomeMessage_gt = welcomeMessage_gt;
    final l$welcomeMessage_gte = welcomeMessage_gte;
    final l$welcomeMessage_in = welcomeMessage_in;
    final l$welcomeMessage_lt = welcomeMessage_lt;
    final l$welcomeMessage_lte = welcomeMessage_lte;
    final l$welcomeMetadata_eq = welcomeMetadata_eq;
    final l$welcomeMetadata_exists = welcomeMetadata_exists;
    final l$welcomeMetadata_gt = welcomeMetadata_gt;
    final l$welcomeMetadata_gte = welcomeMetadata_gte;
    final l$welcomeMetadata_in = welcomeMetadata_in;
    final l$welcomeMetadata_lt = welcomeMetadata_lt;
    final l$welcomeMetadata_lte = welcomeMetadata_lte;
    return Object.hashAll([
      _$data.containsKey('_id_eq') ? l$$_id_eq : const {},
      _$data.containsKey('_id_exists') ? l$$_id_exists : const {},
      _$data.containsKey('_id_gt') ? l$$_id_gt : const {},
      _$data.containsKey('_id_gte') ? l$$_id_gte : const {},
      _$data.containsKey('_id_in')
          ? l$$_id_in == null
              ? null
              : Object.hashAll(l$$_id_in.map((v) => v))
          : const {},
      _$data.containsKey('_id_lt') ? l$$_id_lt : const {},
      _$data.containsKey('_id_lte') ? l$$_id_lte : const {},
      _$data.containsKey('createdAt_eq') ? l$createdAt_eq : const {},
      _$data.containsKey('createdAt_exists') ? l$createdAt_exists : const {},
      _$data.containsKey('createdAt_gt') ? l$createdAt_gt : const {},
      _$data.containsKey('createdAt_gte') ? l$createdAt_gte : const {},
      _$data.containsKey('createdAt_in')
          ? l$createdAt_in == null
              ? null
              : Object.hashAll(l$createdAt_in.map((v) => v))
          : const {},
      _$data.containsKey('createdAt_lt') ? l$createdAt_lt : const {},
      _$data.containsKey('createdAt_lte') ? l$createdAt_lte : const {},
      _$data.containsKey('updatedAt_eq') ? l$updatedAt_eq : const {},
      _$data.containsKey('updatedAt_exists') ? l$updatedAt_exists : const {},
      _$data.containsKey('updatedAt_gt') ? l$updatedAt_gt : const {},
      _$data.containsKey('updatedAt_gte') ? l$updatedAt_gte : const {},
      _$data.containsKey('updatedAt_in')
          ? l$updatedAt_in == null
              ? null
              : Object.hashAll(l$updatedAt_in.map((v) => v))
          : const {},
      _$data.containsKey('updatedAt_lt') ? l$updatedAt_lt : const {},
      _$data.containsKey('updatedAt_lte') ? l$updatedAt_lte : const {},
      _$data.containsKey('avatar_eq') ? l$avatar_eq : const {},
      _$data.containsKey('avatar_exists') ? l$avatar_exists : const {},
      _$data.containsKey('avatar_gt') ? l$avatar_gt : const {},
      _$data.containsKey('avatar_gte') ? l$avatar_gte : const {},
      _$data.containsKey('avatar_in')
          ? l$avatar_in == null
              ? null
              : Object.hashAll(l$avatar_in.map((v) => v))
          : const {},
      _$data.containsKey('avatar_lt') ? l$avatar_lt : const {},
      _$data.containsKey('avatar_lte') ? l$avatar_lte : const {},
      _$data.containsKey('backstory_eq') ? l$backstory_eq : const {},
      _$data.containsKey('backstory_exists') ? l$backstory_exists : const {},
      _$data.containsKey('backstory_gt') ? l$backstory_gt : const {},
      _$data.containsKey('backstory_gte') ? l$backstory_gte : const {},
      _$data.containsKey('backstory_in')
          ? l$backstory_in == null
              ? null
              : Object.hashAll(l$backstory_in.map((v) => v))
          : const {},
      _$data.containsKey('backstory_lt') ? l$backstory_lt : const {},
      _$data.containsKey('backstory_lte') ? l$backstory_lte : const {},
      _$data.containsKey('description_eq') ? l$description_eq : const {},
      _$data.containsKey('description_exists')
          ? l$description_exists
          : const {},
      _$data.containsKey('description_gt') ? l$description_gt : const {},
      _$data.containsKey('description_gte') ? l$description_gte : const {},
      _$data.containsKey('description_in')
          ? l$description_in == null
              ? null
              : Object.hashAll(l$description_in.map((v) => v))
          : const {},
      _$data.containsKey('description_lt') ? l$description_lt : const {},
      _$data.containsKey('description_lte') ? l$description_lte : const {},
      _$data.containsKey('filter_eq') ? l$filter_eq : const {},
      _$data.containsKey('filter_exists') ? l$filter_exists : const {},
      _$data.containsKey('filter_gt') ? l$filter_gt : const {},
      _$data.containsKey('filter_gte') ? l$filter_gte : const {},
      _$data.containsKey('filter_in')
          ? l$filter_in == null
              ? null
              : Object.hashAll(l$filter_in.map((v) => v))
          : const {},
      _$data.containsKey('filter_lt') ? l$filter_lt : const {},
      _$data.containsKey('filter_lte') ? l$filter_lte : const {},
      _$data.containsKey('isPublic_eq') ? l$isPublic_eq : const {},
      _$data.containsKey('isPublic_exists') ? l$isPublic_exists : const {},
      _$data.containsKey('isPublic_gt') ? l$isPublic_gt : const {},
      _$data.containsKey('isPublic_gte') ? l$isPublic_gte : const {},
      _$data.containsKey('isPublic_in')
          ? l$isPublic_in == null
              ? null
              : Object.hashAll(l$isPublic_in.map((v) => v))
          : const {},
      _$data.containsKey('isPublic_lt') ? l$isPublic_lt : const {},
      _$data.containsKey('isPublic_lte') ? l$isPublic_lte : const {},
      _$data.containsKey('job_eq') ? l$job_eq : const {},
      _$data.containsKey('job_exists') ? l$job_exists : const {},
      _$data.containsKey('job_gt') ? l$job_gt : const {},
      _$data.containsKey('job_gte') ? l$job_gte : const {},
      _$data.containsKey('job_in')
          ? l$job_in == null
              ? null
              : Object.hashAll(l$job_in.map((v) => v))
          : const {},
      _$data.containsKey('job_lt') ? l$job_lt : const {},
      _$data.containsKey('job_lte') ? l$job_lte : const {},
      _$data.containsKey('modelName_eq') ? l$modelName_eq : const {},
      _$data.containsKey('modelName_exists') ? l$modelName_exists : const {},
      _$data.containsKey('modelName_gt') ? l$modelName_gt : const {},
      _$data.containsKey('modelName_gte') ? l$modelName_gte : const {},
      _$data.containsKey('modelName_in')
          ? l$modelName_in == null
              ? null
              : Object.hashAll(l$modelName_in.map((v) => v))
          : const {},
      _$data.containsKey('modelName_lt') ? l$modelName_lt : const {},
      _$data.containsKey('modelName_lte') ? l$modelName_lte : const {},
      _$data.containsKey('name_eq') ? l$name_eq : const {},
      _$data.containsKey('name_exists') ? l$name_exists : const {},
      _$data.containsKey('name_gt') ? l$name_gt : const {},
      _$data.containsKey('name_gte') ? l$name_gte : const {},
      _$data.containsKey('name_in')
          ? l$name_in == null
              ? null
              : Object.hashAll(l$name_in.map((v) => v))
          : const {},
      _$data.containsKey('name_lt') ? l$name_lt : const {},
      _$data.containsKey('name_lte') ? l$name_lte : const {},
      _$data.containsKey('openaiApiKey_eq') ? l$openaiApiKey_eq : const {},
      _$data.containsKey('openaiApiKey_exists')
          ? l$openaiApiKey_exists
          : const {},
      _$data.containsKey('openaiApiKey_gt') ? l$openaiApiKey_gt : const {},
      _$data.containsKey('openaiApiKey_gte') ? l$openaiApiKey_gte : const {},
      _$data.containsKey('openaiApiKey_in')
          ? l$openaiApiKey_in == null
              ? null
              : Object.hashAll(l$openaiApiKey_in.map((v) => v))
          : const {},
      _$data.containsKey('openaiApiKey_lt') ? l$openaiApiKey_lt : const {},
      _$data.containsKey('openaiApiKey_lte') ? l$openaiApiKey_lte : const {},
      _$data.containsKey('systemMessage_eq') ? l$systemMessage_eq : const {},
      _$data.containsKey('systemMessage_exists')
          ? l$systemMessage_exists
          : const {},
      _$data.containsKey('systemMessage_gt') ? l$systemMessage_gt : const {},
      _$data.containsKey('systemMessage_gte') ? l$systemMessage_gte : const {},
      _$data.containsKey('systemMessage_in')
          ? l$systemMessage_in == null
              ? null
              : Object.hashAll(l$systemMessage_in.map((v) => v))
          : const {},
      _$data.containsKey('systemMessage_lt') ? l$systemMessage_lt : const {},
      _$data.containsKey('systemMessage_lte') ? l$systemMessage_lte : const {},
      _$data.containsKey('temperature_eq') ? l$temperature_eq : const {},
      _$data.containsKey('temperature_exists')
          ? l$temperature_exists
          : const {},
      _$data.containsKey('temperature_gt') ? l$temperature_gt : const {},
      _$data.containsKey('temperature_gte') ? l$temperature_gte : const {},
      _$data.containsKey('temperature_in')
          ? l$temperature_in == null
              ? null
              : Object.hashAll(l$temperature_in.map((v) => v))
          : const {},
      _$data.containsKey('temperature_lt') ? l$temperature_lt : const {},
      _$data.containsKey('temperature_lte') ? l$temperature_lte : const {},
      _$data.containsKey('topP_eq') ? l$topP_eq : const {},
      _$data.containsKey('topP_exists') ? l$topP_exists : const {},
      _$data.containsKey('topP_gt') ? l$topP_gt : const {},
      _$data.containsKey('topP_gte') ? l$topP_gte : const {},
      _$data.containsKey('topP_in')
          ? l$topP_in == null
              ? null
              : Object.hashAll(l$topP_in.map((v) => v))
          : const {},
      _$data.containsKey('topP_lt') ? l$topP_lt : const {},
      _$data.containsKey('topP_lte') ? l$topP_lte : const {},
      _$data.containsKey('user_eq') ? l$user_eq : const {},
      _$data.containsKey('user_exists') ? l$user_exists : const {},
      _$data.containsKey('user_gt') ? l$user_gt : const {},
      _$data.containsKey('user_gte') ? l$user_gte : const {},
      _$data.containsKey('user_in')
          ? l$user_in == null
              ? null
              : Object.hashAll(l$user_in.map((v) => v))
          : const {},
      _$data.containsKey('user_lt') ? l$user_lt : const {},
      _$data.containsKey('user_lte') ? l$user_lte : const {},
      _$data.containsKey('welcomeMessage_eq') ? l$welcomeMessage_eq : const {},
      _$data.containsKey('welcomeMessage_exists')
          ? l$welcomeMessage_exists
          : const {},
      _$data.containsKey('welcomeMessage_gt') ? l$welcomeMessage_gt : const {},
      _$data.containsKey('welcomeMessage_gte')
          ? l$welcomeMessage_gte
          : const {},
      _$data.containsKey('welcomeMessage_in')
          ? l$welcomeMessage_in == null
              ? null
              : Object.hashAll(l$welcomeMessage_in.map((v) => v))
          : const {},
      _$data.containsKey('welcomeMessage_lt') ? l$welcomeMessage_lt : const {},
      _$data.containsKey('welcomeMessage_lte')
          ? l$welcomeMessage_lte
          : const {},
      _$data.containsKey('welcomeMetadata_eq')
          ? l$welcomeMetadata_eq
          : const {},
      _$data.containsKey('welcomeMetadata_exists')
          ? l$welcomeMetadata_exists
          : const {},
      _$data.containsKey('welcomeMetadata_gt')
          ? l$welcomeMetadata_gt
          : const {},
      _$data.containsKey('welcomeMetadata_gte')
          ? l$welcomeMetadata_gte
          : const {},
      _$data.containsKey('welcomeMetadata_in')
          ? l$welcomeMetadata_in == null
              ? null
              : Object.hashAll(l$welcomeMetadata_in.map((v) => v))
          : const {},
      _$data.containsKey('welcomeMetadata_lt')
          ? l$welcomeMetadata_lt
          : const {},
      _$data.containsKey('welcomeMetadata_lte')
          ? l$welcomeMetadata_lte
          : const {},
    ]);
  }
}

abstract class CopyWith$Input$ConfigFilter<TRes> {
  factory CopyWith$Input$ConfigFilter(
    Input$ConfigFilter instance,
    TRes Function(Input$ConfigFilter) then,
  ) = _CopyWithImpl$Input$ConfigFilter;

  factory CopyWith$Input$ConfigFilter.stub(TRes res) =
      _CopyWithStubImpl$Input$ConfigFilter;

  TRes call({
    String? $_id_eq,
    bool? $_id_exists,
    String? $_id_gt,
    String? $_id_gte,
    List<String>? $_id_in,
    String? $_id_lt,
    String? $_id_lte,
    String? createdAt_eq,
    bool? createdAt_exists,
    String? createdAt_gt,
    String? createdAt_gte,
    List<String>? createdAt_in,
    String? createdAt_lt,
    String? createdAt_lte,
    String? updatedAt_eq,
    bool? updatedAt_exists,
    String? updatedAt_gt,
    String? updatedAt_gte,
    List<String>? updatedAt_in,
    String? updatedAt_lt,
    String? updatedAt_lte,
    String? avatar_eq,
    bool? avatar_exists,
    String? avatar_gt,
    String? avatar_gte,
    List<String>? avatar_in,
    String? avatar_lt,
    String? avatar_lte,
    String? backstory_eq,
    bool? backstory_exists,
    String? backstory_gt,
    String? backstory_gte,
    List<String>? backstory_in,
    String? backstory_lt,
    String? backstory_lte,
    String? description_eq,
    bool? description_exists,
    String? description_gt,
    String? description_gte,
    List<String>? description_in,
    String? description_lt,
    String? description_lte,
    Map<String, dynamic>? filter_eq,
    bool? filter_exists,
    Map<String, dynamic>? filter_gt,
    Map<String, dynamic>? filter_gte,
    List<Map<String, dynamic>>? filter_in,
    Map<String, dynamic>? filter_lt,
    Map<String, dynamic>? filter_lte,
    bool? isPublic_eq,
    bool? isPublic_exists,
    bool? isPublic_gt,
    bool? isPublic_gte,
    List<bool>? isPublic_in,
    bool? isPublic_lt,
    bool? isPublic_lte,
    String? job_eq,
    bool? job_exists,
    String? job_gt,
    String? job_gte,
    List<String>? job_in,
    String? job_lt,
    String? job_lte,
    String? modelName_eq,
    bool? modelName_exists,
    String? modelName_gt,
    String? modelName_gte,
    List<String>? modelName_in,
    String? modelName_lt,
    String? modelName_lte,
    String? name_eq,
    bool? name_exists,
    String? name_gt,
    String? name_gte,
    List<String>? name_in,
    String? name_lt,
    String? name_lte,
    String? openaiApiKey_eq,
    bool? openaiApiKey_exists,
    String? openaiApiKey_gt,
    String? openaiApiKey_gte,
    List<String>? openaiApiKey_in,
    String? openaiApiKey_lt,
    String? openaiApiKey_lte,
    String? systemMessage_eq,
    bool? systemMessage_exists,
    String? systemMessage_gt,
    String? systemMessage_gte,
    List<String>? systemMessage_in,
    String? systemMessage_lt,
    String? systemMessage_lte,
    double? temperature_eq,
    bool? temperature_exists,
    double? temperature_gt,
    double? temperature_gte,
    List<double>? temperature_in,
    double? temperature_lt,
    double? temperature_lte,
    double? topP_eq,
    bool? topP_exists,
    double? topP_gt,
    double? topP_gte,
    List<double>? topP_in,
    double? topP_lt,
    double? topP_lte,
    String? user_eq,
    bool? user_exists,
    String? user_gt,
    String? user_gte,
    List<String>? user_in,
    String? user_lt,
    String? user_lte,
    String? welcomeMessage_eq,
    bool? welcomeMessage_exists,
    String? welcomeMessage_gt,
    String? welcomeMessage_gte,
    List<String>? welcomeMessage_in,
    String? welcomeMessage_lt,
    String? welcomeMessage_lte,
    Map<String, dynamic>? welcomeMetadata_eq,
    bool? welcomeMetadata_exists,
    Map<String, dynamic>? welcomeMetadata_gt,
    Map<String, dynamic>? welcomeMetadata_gte,
    List<Map<String, dynamic>>? welcomeMetadata_in,
    Map<String, dynamic>? welcomeMetadata_lt,
    Map<String, dynamic>? welcomeMetadata_lte,
  });
}

class _CopyWithImpl$Input$ConfigFilter<TRes>
    implements CopyWith$Input$ConfigFilter<TRes> {
  _CopyWithImpl$Input$ConfigFilter(
    this._instance,
    this._then,
  );

  final Input$ConfigFilter _instance;

  final TRes Function(Input$ConfigFilter) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? $_id_eq = _undefined,
    Object? $_id_exists = _undefined,
    Object? $_id_gt = _undefined,
    Object? $_id_gte = _undefined,
    Object? $_id_in = _undefined,
    Object? $_id_lt = _undefined,
    Object? $_id_lte = _undefined,
    Object? createdAt_eq = _undefined,
    Object? createdAt_exists = _undefined,
    Object? createdAt_gt = _undefined,
    Object? createdAt_gte = _undefined,
    Object? createdAt_in = _undefined,
    Object? createdAt_lt = _undefined,
    Object? createdAt_lte = _undefined,
    Object? updatedAt_eq = _undefined,
    Object? updatedAt_exists = _undefined,
    Object? updatedAt_gt = _undefined,
    Object? updatedAt_gte = _undefined,
    Object? updatedAt_in = _undefined,
    Object? updatedAt_lt = _undefined,
    Object? updatedAt_lte = _undefined,
    Object? avatar_eq = _undefined,
    Object? avatar_exists = _undefined,
    Object? avatar_gt = _undefined,
    Object? avatar_gte = _undefined,
    Object? avatar_in = _undefined,
    Object? avatar_lt = _undefined,
    Object? avatar_lte = _undefined,
    Object? backstory_eq = _undefined,
    Object? backstory_exists = _undefined,
    Object? backstory_gt = _undefined,
    Object? backstory_gte = _undefined,
    Object? backstory_in = _undefined,
    Object? backstory_lt = _undefined,
    Object? backstory_lte = _undefined,
    Object? description_eq = _undefined,
    Object? description_exists = _undefined,
    Object? description_gt = _undefined,
    Object? description_gte = _undefined,
    Object? description_in = _undefined,
    Object? description_lt = _undefined,
    Object? description_lte = _undefined,
    Object? filter_eq = _undefined,
    Object? filter_exists = _undefined,
    Object? filter_gt = _undefined,
    Object? filter_gte = _undefined,
    Object? filter_in = _undefined,
    Object? filter_lt = _undefined,
    Object? filter_lte = _undefined,
    Object? isPublic_eq = _undefined,
    Object? isPublic_exists = _undefined,
    Object? isPublic_gt = _undefined,
    Object? isPublic_gte = _undefined,
    Object? isPublic_in = _undefined,
    Object? isPublic_lt = _undefined,
    Object? isPublic_lte = _undefined,
    Object? job_eq = _undefined,
    Object? job_exists = _undefined,
    Object? job_gt = _undefined,
    Object? job_gte = _undefined,
    Object? job_in = _undefined,
    Object? job_lt = _undefined,
    Object? job_lte = _undefined,
    Object? modelName_eq = _undefined,
    Object? modelName_exists = _undefined,
    Object? modelName_gt = _undefined,
    Object? modelName_gte = _undefined,
    Object? modelName_in = _undefined,
    Object? modelName_lt = _undefined,
    Object? modelName_lte = _undefined,
    Object? name_eq = _undefined,
    Object? name_exists = _undefined,
    Object? name_gt = _undefined,
    Object? name_gte = _undefined,
    Object? name_in = _undefined,
    Object? name_lt = _undefined,
    Object? name_lte = _undefined,
    Object? openaiApiKey_eq = _undefined,
    Object? openaiApiKey_exists = _undefined,
    Object? openaiApiKey_gt = _undefined,
    Object? openaiApiKey_gte = _undefined,
    Object? openaiApiKey_in = _undefined,
    Object? openaiApiKey_lt = _undefined,
    Object? openaiApiKey_lte = _undefined,
    Object? systemMessage_eq = _undefined,
    Object? systemMessage_exists = _undefined,
    Object? systemMessage_gt = _undefined,
    Object? systemMessage_gte = _undefined,
    Object? systemMessage_in = _undefined,
    Object? systemMessage_lt = _undefined,
    Object? systemMessage_lte = _undefined,
    Object? temperature_eq = _undefined,
    Object? temperature_exists = _undefined,
    Object? temperature_gt = _undefined,
    Object? temperature_gte = _undefined,
    Object? temperature_in = _undefined,
    Object? temperature_lt = _undefined,
    Object? temperature_lte = _undefined,
    Object? topP_eq = _undefined,
    Object? topP_exists = _undefined,
    Object? topP_gt = _undefined,
    Object? topP_gte = _undefined,
    Object? topP_in = _undefined,
    Object? topP_lt = _undefined,
    Object? topP_lte = _undefined,
    Object? user_eq = _undefined,
    Object? user_exists = _undefined,
    Object? user_gt = _undefined,
    Object? user_gte = _undefined,
    Object? user_in = _undefined,
    Object? user_lt = _undefined,
    Object? user_lte = _undefined,
    Object? welcomeMessage_eq = _undefined,
    Object? welcomeMessage_exists = _undefined,
    Object? welcomeMessage_gt = _undefined,
    Object? welcomeMessage_gte = _undefined,
    Object? welcomeMessage_in = _undefined,
    Object? welcomeMessage_lt = _undefined,
    Object? welcomeMessage_lte = _undefined,
    Object? welcomeMetadata_eq = _undefined,
    Object? welcomeMetadata_exists = _undefined,
    Object? welcomeMetadata_gt = _undefined,
    Object? welcomeMetadata_gte = _undefined,
    Object? welcomeMetadata_in = _undefined,
    Object? welcomeMetadata_lt = _undefined,
    Object? welcomeMetadata_lte = _undefined,
  }) =>
      _then(Input$ConfigFilter._({
        ..._instance._$data,
        if ($_id_eq != _undefined) '_id_eq': ($_id_eq as String?),
        if ($_id_exists != _undefined) '_id_exists': ($_id_exists as bool?),
        if ($_id_gt != _undefined) '_id_gt': ($_id_gt as String?),
        if ($_id_gte != _undefined) '_id_gte': ($_id_gte as String?),
        if ($_id_in != _undefined) '_id_in': ($_id_in as List<String>?),
        if ($_id_lt != _undefined) '_id_lt': ($_id_lt as String?),
        if ($_id_lte != _undefined) '_id_lte': ($_id_lte as String?),
        if (createdAt_eq != _undefined)
          'createdAt_eq': (createdAt_eq as String?),
        if (createdAt_exists != _undefined)
          'createdAt_exists': (createdAt_exists as bool?),
        if (createdAt_gt != _undefined)
          'createdAt_gt': (createdAt_gt as String?),
        if (createdAt_gte != _undefined)
          'createdAt_gte': (createdAt_gte as String?),
        if (createdAt_in != _undefined)
          'createdAt_in': (createdAt_in as List<String>?),
        if (createdAt_lt != _undefined)
          'createdAt_lt': (createdAt_lt as String?),
        if (createdAt_lte != _undefined)
          'createdAt_lte': (createdAt_lte as String?),
        if (updatedAt_eq != _undefined)
          'updatedAt_eq': (updatedAt_eq as String?),
        if (updatedAt_exists != _undefined)
          'updatedAt_exists': (updatedAt_exists as bool?),
        if (updatedAt_gt != _undefined)
          'updatedAt_gt': (updatedAt_gt as String?),
        if (updatedAt_gte != _undefined)
          'updatedAt_gte': (updatedAt_gte as String?),
        if (updatedAt_in != _undefined)
          'updatedAt_in': (updatedAt_in as List<String>?),
        if (updatedAt_lt != _undefined)
          'updatedAt_lt': (updatedAt_lt as String?),
        if (updatedAt_lte != _undefined)
          'updatedAt_lte': (updatedAt_lte as String?),
        if (avatar_eq != _undefined) 'avatar_eq': (avatar_eq as String?),
        if (avatar_exists != _undefined)
          'avatar_exists': (avatar_exists as bool?),
        if (avatar_gt != _undefined) 'avatar_gt': (avatar_gt as String?),
        if (avatar_gte != _undefined) 'avatar_gte': (avatar_gte as String?),
        if (avatar_in != _undefined) 'avatar_in': (avatar_in as List<String>?),
        if (avatar_lt != _undefined) 'avatar_lt': (avatar_lt as String?),
        if (avatar_lte != _undefined) 'avatar_lte': (avatar_lte as String?),
        if (backstory_eq != _undefined)
          'backstory_eq': (backstory_eq as String?),
        if (backstory_exists != _undefined)
          'backstory_exists': (backstory_exists as bool?),
        if (backstory_gt != _undefined)
          'backstory_gt': (backstory_gt as String?),
        if (backstory_gte != _undefined)
          'backstory_gte': (backstory_gte as String?),
        if (backstory_in != _undefined)
          'backstory_in': (backstory_in as List<String>?),
        if (backstory_lt != _undefined)
          'backstory_lt': (backstory_lt as String?),
        if (backstory_lte != _undefined)
          'backstory_lte': (backstory_lte as String?),
        if (description_eq != _undefined)
          'description_eq': (description_eq as String?),
        if (description_exists != _undefined)
          'description_exists': (description_exists as bool?),
        if (description_gt != _undefined)
          'description_gt': (description_gt as String?),
        if (description_gte != _undefined)
          'description_gte': (description_gte as String?),
        if (description_in != _undefined)
          'description_in': (description_in as List<String>?),
        if (description_lt != _undefined)
          'description_lt': (description_lt as String?),
        if (description_lte != _undefined)
          'description_lte': (description_lte as String?),
        if (filter_eq != _undefined)
          'filter_eq': (filter_eq as Map<String, dynamic>?),
        if (filter_exists != _undefined)
          'filter_exists': (filter_exists as bool?),
        if (filter_gt != _undefined)
          'filter_gt': (filter_gt as Map<String, dynamic>?),
        if (filter_gte != _undefined)
          'filter_gte': (filter_gte as Map<String, dynamic>?),
        if (filter_in != _undefined)
          'filter_in': (filter_in as List<Map<String, dynamic>>?),
        if (filter_lt != _undefined)
          'filter_lt': (filter_lt as Map<String, dynamic>?),
        if (filter_lte != _undefined)
          'filter_lte': (filter_lte as Map<String, dynamic>?),
        if (isPublic_eq != _undefined) 'isPublic_eq': (isPublic_eq as bool?),
        if (isPublic_exists != _undefined)
          'isPublic_exists': (isPublic_exists as bool?),
        if (isPublic_gt != _undefined) 'isPublic_gt': (isPublic_gt as bool?),
        if (isPublic_gte != _undefined) 'isPublic_gte': (isPublic_gte as bool?),
        if (isPublic_in != _undefined)
          'isPublic_in': (isPublic_in as List<bool>?),
        if (isPublic_lt != _undefined) 'isPublic_lt': (isPublic_lt as bool?),
        if (isPublic_lte != _undefined) 'isPublic_lte': (isPublic_lte as bool?),
        if (job_eq != _undefined) 'job_eq': (job_eq as String?),
        if (job_exists != _undefined) 'job_exists': (job_exists as bool?),
        if (job_gt != _undefined) 'job_gt': (job_gt as String?),
        if (job_gte != _undefined) 'job_gte': (job_gte as String?),
        if (job_in != _undefined) 'job_in': (job_in as List<String>?),
        if (job_lt != _undefined) 'job_lt': (job_lt as String?),
        if (job_lte != _undefined) 'job_lte': (job_lte as String?),
        if (modelName_eq != _undefined)
          'modelName_eq': (modelName_eq as String?),
        if (modelName_exists != _undefined)
          'modelName_exists': (modelName_exists as bool?),
        if (modelName_gt != _undefined)
          'modelName_gt': (modelName_gt as String?),
        if (modelName_gte != _undefined)
          'modelName_gte': (modelName_gte as String?),
        if (modelName_in != _undefined)
          'modelName_in': (modelName_in as List<String>?),
        if (modelName_lt != _undefined)
          'modelName_lt': (modelName_lt as String?),
        if (modelName_lte != _undefined)
          'modelName_lte': (modelName_lte as String?),
        if (name_eq != _undefined) 'name_eq': (name_eq as String?),
        if (name_exists != _undefined) 'name_exists': (name_exists as bool?),
        if (name_gt != _undefined) 'name_gt': (name_gt as String?),
        if (name_gte != _undefined) 'name_gte': (name_gte as String?),
        if (name_in != _undefined) 'name_in': (name_in as List<String>?),
        if (name_lt != _undefined) 'name_lt': (name_lt as String?),
        if (name_lte != _undefined) 'name_lte': (name_lte as String?),
        if (openaiApiKey_eq != _undefined)
          'openaiApiKey_eq': (openaiApiKey_eq as String?),
        if (openaiApiKey_exists != _undefined)
          'openaiApiKey_exists': (openaiApiKey_exists as bool?),
        if (openaiApiKey_gt != _undefined)
          'openaiApiKey_gt': (openaiApiKey_gt as String?),
        if (openaiApiKey_gte != _undefined)
          'openaiApiKey_gte': (openaiApiKey_gte as String?),
        if (openaiApiKey_in != _undefined)
          'openaiApiKey_in': (openaiApiKey_in as List<String>?),
        if (openaiApiKey_lt != _undefined)
          'openaiApiKey_lt': (openaiApiKey_lt as String?),
        if (openaiApiKey_lte != _undefined)
          'openaiApiKey_lte': (openaiApiKey_lte as String?),
        if (systemMessage_eq != _undefined)
          'systemMessage_eq': (systemMessage_eq as String?),
        if (systemMessage_exists != _undefined)
          'systemMessage_exists': (systemMessage_exists as bool?),
        if (systemMessage_gt != _undefined)
          'systemMessage_gt': (systemMessage_gt as String?),
        if (systemMessage_gte != _undefined)
          'systemMessage_gte': (systemMessage_gte as String?),
        if (systemMessage_in != _undefined)
          'systemMessage_in': (systemMessage_in as List<String>?),
        if (systemMessage_lt != _undefined)
          'systemMessage_lt': (systemMessage_lt as String?),
        if (systemMessage_lte != _undefined)
          'systemMessage_lte': (systemMessage_lte as String?),
        if (temperature_eq != _undefined)
          'temperature_eq': (temperature_eq as double?),
        if (temperature_exists != _undefined)
          'temperature_exists': (temperature_exists as bool?),
        if (temperature_gt != _undefined)
          'temperature_gt': (temperature_gt as double?),
        if (temperature_gte != _undefined)
          'temperature_gte': (temperature_gte as double?),
        if (temperature_in != _undefined)
          'temperature_in': (temperature_in as List<double>?),
        if (temperature_lt != _undefined)
          'temperature_lt': (temperature_lt as double?),
        if (temperature_lte != _undefined)
          'temperature_lte': (temperature_lte as double?),
        if (topP_eq != _undefined) 'topP_eq': (topP_eq as double?),
        if (topP_exists != _undefined) 'topP_exists': (topP_exists as bool?),
        if (topP_gt != _undefined) 'topP_gt': (topP_gt as double?),
        if (topP_gte != _undefined) 'topP_gte': (topP_gte as double?),
        if (topP_in != _undefined) 'topP_in': (topP_in as List<double>?),
        if (topP_lt != _undefined) 'topP_lt': (topP_lt as double?),
        if (topP_lte != _undefined) 'topP_lte': (topP_lte as double?),
        if (user_eq != _undefined) 'user_eq': (user_eq as String?),
        if (user_exists != _undefined) 'user_exists': (user_exists as bool?),
        if (user_gt != _undefined) 'user_gt': (user_gt as String?),
        if (user_gte != _undefined) 'user_gte': (user_gte as String?),
        if (user_in != _undefined) 'user_in': (user_in as List<String>?),
        if (user_lt != _undefined) 'user_lt': (user_lt as String?),
        if (user_lte != _undefined) 'user_lte': (user_lte as String?),
        if (welcomeMessage_eq != _undefined)
          'welcomeMessage_eq': (welcomeMessage_eq as String?),
        if (welcomeMessage_exists != _undefined)
          'welcomeMessage_exists': (welcomeMessage_exists as bool?),
        if (welcomeMessage_gt != _undefined)
          'welcomeMessage_gt': (welcomeMessage_gt as String?),
        if (welcomeMessage_gte != _undefined)
          'welcomeMessage_gte': (welcomeMessage_gte as String?),
        if (welcomeMessage_in != _undefined)
          'welcomeMessage_in': (welcomeMessage_in as List<String>?),
        if (welcomeMessage_lt != _undefined)
          'welcomeMessage_lt': (welcomeMessage_lt as String?),
        if (welcomeMessage_lte != _undefined)
          'welcomeMessage_lte': (welcomeMessage_lte as String?),
        if (welcomeMetadata_eq != _undefined)
          'welcomeMetadata_eq': (welcomeMetadata_eq as Map<String, dynamic>?),
        if (welcomeMetadata_exists != _undefined)
          'welcomeMetadata_exists': (welcomeMetadata_exists as bool?),
        if (welcomeMetadata_gt != _undefined)
          'welcomeMetadata_gt': (welcomeMetadata_gt as Map<String, dynamic>?),
        if (welcomeMetadata_gte != _undefined)
          'welcomeMetadata_gte': (welcomeMetadata_gte as Map<String, dynamic>?),
        if (welcomeMetadata_in != _undefined)
          'welcomeMetadata_in':
              (welcomeMetadata_in as List<Map<String, dynamic>>?),
        if (welcomeMetadata_lt != _undefined)
          'welcomeMetadata_lt': (welcomeMetadata_lt as Map<String, dynamic>?),
        if (welcomeMetadata_lte != _undefined)
          'welcomeMetadata_lte': (welcomeMetadata_lte as Map<String, dynamic>?),
      }));
}

class _CopyWithStubImpl$Input$ConfigFilter<TRes>
    implements CopyWith$Input$ConfigFilter<TRes> {
  _CopyWithStubImpl$Input$ConfigFilter(this._res);

  TRes _res;

  call({
    String? $_id_eq,
    bool? $_id_exists,
    String? $_id_gt,
    String? $_id_gte,
    List<String>? $_id_in,
    String? $_id_lt,
    String? $_id_lte,
    String? createdAt_eq,
    bool? createdAt_exists,
    String? createdAt_gt,
    String? createdAt_gte,
    List<String>? createdAt_in,
    String? createdAt_lt,
    String? createdAt_lte,
    String? updatedAt_eq,
    bool? updatedAt_exists,
    String? updatedAt_gt,
    String? updatedAt_gte,
    List<String>? updatedAt_in,
    String? updatedAt_lt,
    String? updatedAt_lte,
    String? avatar_eq,
    bool? avatar_exists,
    String? avatar_gt,
    String? avatar_gte,
    List<String>? avatar_in,
    String? avatar_lt,
    String? avatar_lte,
    String? backstory_eq,
    bool? backstory_exists,
    String? backstory_gt,
    String? backstory_gte,
    List<String>? backstory_in,
    String? backstory_lt,
    String? backstory_lte,
    String? description_eq,
    bool? description_exists,
    String? description_gt,
    String? description_gte,
    List<String>? description_in,
    String? description_lt,
    String? description_lte,
    Map<String, dynamic>? filter_eq,
    bool? filter_exists,
    Map<String, dynamic>? filter_gt,
    Map<String, dynamic>? filter_gte,
    List<Map<String, dynamic>>? filter_in,
    Map<String, dynamic>? filter_lt,
    Map<String, dynamic>? filter_lte,
    bool? isPublic_eq,
    bool? isPublic_exists,
    bool? isPublic_gt,
    bool? isPublic_gte,
    List<bool>? isPublic_in,
    bool? isPublic_lt,
    bool? isPublic_lte,
    String? job_eq,
    bool? job_exists,
    String? job_gt,
    String? job_gte,
    List<String>? job_in,
    String? job_lt,
    String? job_lte,
    String? modelName_eq,
    bool? modelName_exists,
    String? modelName_gt,
    String? modelName_gte,
    List<String>? modelName_in,
    String? modelName_lt,
    String? modelName_lte,
    String? name_eq,
    bool? name_exists,
    String? name_gt,
    String? name_gte,
    List<String>? name_in,
    String? name_lt,
    String? name_lte,
    String? openaiApiKey_eq,
    bool? openaiApiKey_exists,
    String? openaiApiKey_gt,
    String? openaiApiKey_gte,
    List<String>? openaiApiKey_in,
    String? openaiApiKey_lt,
    String? openaiApiKey_lte,
    String? systemMessage_eq,
    bool? systemMessage_exists,
    String? systemMessage_gt,
    String? systemMessage_gte,
    List<String>? systemMessage_in,
    String? systemMessage_lt,
    String? systemMessage_lte,
    double? temperature_eq,
    bool? temperature_exists,
    double? temperature_gt,
    double? temperature_gte,
    List<double>? temperature_in,
    double? temperature_lt,
    double? temperature_lte,
    double? topP_eq,
    bool? topP_exists,
    double? topP_gt,
    double? topP_gte,
    List<double>? topP_in,
    double? topP_lt,
    double? topP_lte,
    String? user_eq,
    bool? user_exists,
    String? user_gt,
    String? user_gte,
    List<String>? user_in,
    String? user_lt,
    String? user_lte,
    String? welcomeMessage_eq,
    bool? welcomeMessage_exists,
    String? welcomeMessage_gt,
    String? welcomeMessage_gte,
    List<String>? welcomeMessage_in,
    String? welcomeMessage_lt,
    String? welcomeMessage_lte,
    Map<String, dynamic>? welcomeMetadata_eq,
    bool? welcomeMetadata_exists,
    Map<String, dynamic>? welcomeMetadata_gt,
    Map<String, dynamic>? welcomeMetadata_gte,
    List<Map<String, dynamic>>? welcomeMetadata_in,
    Map<String, dynamic>? welcomeMetadata_lt,
    Map<String, dynamic>? welcomeMetadata_lte,
  }) =>
      _res;
}

class Input$DocumentFilter {
  factory Input$DocumentFilter({
    String? $_id_eq,
    bool? $_id_exists,
    String? $_id_gt,
    String? $_id_gte,
    List<String>? $_id_in,
    String? $_id_lt,
    String? $_id_lte,
    String? createdAt_eq,
    bool? createdAt_exists,
    String? createdAt_gt,
    String? createdAt_gte,
    List<String>? createdAt_in,
    String? createdAt_lt,
    String? createdAt_lte,
    String? updatedAt_eq,
    bool? updatedAt_exists,
    String? updatedAt_gt,
    String? updatedAt_gte,
    List<String>? updatedAt_in,
    String? updatedAt_lt,
    String? updatedAt_lte,
    Map<String, dynamic>? metadata_eq,
    bool? metadata_exists,
    Map<String, dynamic>? metadata_gt,
    Map<String, dynamic>? metadata_gte,
    List<Map<String, dynamic>>? metadata_in,
    Map<String, dynamic>? metadata_lt,
    Map<String, dynamic>? metadata_lte,
    String? text_eq,
    bool? text_exists,
    String? text_gt,
    String? text_gte,
    List<String>? text_in,
    String? text_lt,
    String? text_lte,
    String? user_eq,
    bool? user_exists,
    String? user_gt,
    String? user_gte,
    List<String>? user_in,
    String? user_lt,
    String? user_lte,
  }) =>
      Input$DocumentFilter._({
        if ($_id_eq != null) r'_id_eq': $_id_eq,
        if ($_id_exists != null) r'_id_exists': $_id_exists,
        if ($_id_gt != null) r'_id_gt': $_id_gt,
        if ($_id_gte != null) r'_id_gte': $_id_gte,
        if ($_id_in != null) r'_id_in': $_id_in,
        if ($_id_lt != null) r'_id_lt': $_id_lt,
        if ($_id_lte != null) r'_id_lte': $_id_lte,
        if (createdAt_eq != null) r'createdAt_eq': createdAt_eq,
        if (createdAt_exists != null) r'createdAt_exists': createdAt_exists,
        if (createdAt_gt != null) r'createdAt_gt': createdAt_gt,
        if (createdAt_gte != null) r'createdAt_gte': createdAt_gte,
        if (createdAt_in != null) r'createdAt_in': createdAt_in,
        if (createdAt_lt != null) r'createdAt_lt': createdAt_lt,
        if (createdAt_lte != null) r'createdAt_lte': createdAt_lte,
        if (updatedAt_eq != null) r'updatedAt_eq': updatedAt_eq,
        if (updatedAt_exists != null) r'updatedAt_exists': updatedAt_exists,
        if (updatedAt_gt != null) r'updatedAt_gt': updatedAt_gt,
        if (updatedAt_gte != null) r'updatedAt_gte': updatedAt_gte,
        if (updatedAt_in != null) r'updatedAt_in': updatedAt_in,
        if (updatedAt_lt != null) r'updatedAt_lt': updatedAt_lt,
        if (updatedAt_lte != null) r'updatedAt_lte': updatedAt_lte,
        if (metadata_eq != null) r'metadata_eq': metadata_eq,
        if (metadata_exists != null) r'metadata_exists': metadata_exists,
        if (metadata_gt != null) r'metadata_gt': metadata_gt,
        if (metadata_gte != null) r'metadata_gte': metadata_gte,
        if (metadata_in != null) r'metadata_in': metadata_in,
        if (metadata_lt != null) r'metadata_lt': metadata_lt,
        if (metadata_lte != null) r'metadata_lte': metadata_lte,
        if (text_eq != null) r'text_eq': text_eq,
        if (text_exists != null) r'text_exists': text_exists,
        if (text_gt != null) r'text_gt': text_gt,
        if (text_gte != null) r'text_gte': text_gte,
        if (text_in != null) r'text_in': text_in,
        if (text_lt != null) r'text_lt': text_lt,
        if (text_lte != null) r'text_lte': text_lte,
        if (user_eq != null) r'user_eq': user_eq,
        if (user_exists != null) r'user_exists': user_exists,
        if (user_gt != null) r'user_gt': user_gt,
        if (user_gte != null) r'user_gte': user_gte,
        if (user_in != null) r'user_in': user_in,
        if (user_lt != null) r'user_lt': user_lt,
        if (user_lte != null) r'user_lte': user_lte,
      });

  Input$DocumentFilter._(this._$data);

  factory Input$DocumentFilter.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    if (data.containsKey('_id_eq')) {
      final l$$_id_eq = data['_id_eq'];
      result$data['_id_eq'] = (l$$_id_eq as String?);
    }
    if (data.containsKey('_id_exists')) {
      final l$$_id_exists = data['_id_exists'];
      result$data['_id_exists'] = (l$$_id_exists as bool?);
    }
    if (data.containsKey('_id_gt')) {
      final l$$_id_gt = data['_id_gt'];
      result$data['_id_gt'] = (l$$_id_gt as String?);
    }
    if (data.containsKey('_id_gte')) {
      final l$$_id_gte = data['_id_gte'];
      result$data['_id_gte'] = (l$$_id_gte as String?);
    }
    if (data.containsKey('_id_in')) {
      final l$$_id_in = data['_id_in'];
      result$data['_id_in'] =
          (l$$_id_in as List<dynamic>?)?.map((e) => (e as String)).toList();
    }
    if (data.containsKey('_id_lt')) {
      final l$$_id_lt = data['_id_lt'];
      result$data['_id_lt'] = (l$$_id_lt as String?);
    }
    if (data.containsKey('_id_lte')) {
      final l$$_id_lte = data['_id_lte'];
      result$data['_id_lte'] = (l$$_id_lte as String?);
    }
    if (data.containsKey('createdAt_eq')) {
      final l$createdAt_eq = data['createdAt_eq'];
      result$data['createdAt_eq'] = (l$createdAt_eq as String?);
    }
    if (data.containsKey('createdAt_exists')) {
      final l$createdAt_exists = data['createdAt_exists'];
      result$data['createdAt_exists'] = (l$createdAt_exists as bool?);
    }
    if (data.containsKey('createdAt_gt')) {
      final l$createdAt_gt = data['createdAt_gt'];
      result$data['createdAt_gt'] = (l$createdAt_gt as String?);
    }
    if (data.containsKey('createdAt_gte')) {
      final l$createdAt_gte = data['createdAt_gte'];
      result$data['createdAt_gte'] = (l$createdAt_gte as String?);
    }
    if (data.containsKey('createdAt_in')) {
      final l$createdAt_in = data['createdAt_in'];
      result$data['createdAt_in'] = (l$createdAt_in as List<dynamic>?)
          ?.map((e) => (e as String))
          .toList();
    }
    if (data.containsKey('createdAt_lt')) {
      final l$createdAt_lt = data['createdAt_lt'];
      result$data['createdAt_lt'] = (l$createdAt_lt as String?);
    }
    if (data.containsKey('createdAt_lte')) {
      final l$createdAt_lte = data['createdAt_lte'];
      result$data['createdAt_lte'] = (l$createdAt_lte as String?);
    }
    if (data.containsKey('updatedAt_eq')) {
      final l$updatedAt_eq = data['updatedAt_eq'];
      result$data['updatedAt_eq'] = (l$updatedAt_eq as String?);
    }
    if (data.containsKey('updatedAt_exists')) {
      final l$updatedAt_exists = data['updatedAt_exists'];
      result$data['updatedAt_exists'] = (l$updatedAt_exists as bool?);
    }
    if (data.containsKey('updatedAt_gt')) {
      final l$updatedAt_gt = data['updatedAt_gt'];
      result$data['updatedAt_gt'] = (l$updatedAt_gt as String?);
    }
    if (data.containsKey('updatedAt_gte')) {
      final l$updatedAt_gte = data['updatedAt_gte'];
      result$data['updatedAt_gte'] = (l$updatedAt_gte as String?);
    }
    if (data.containsKey('updatedAt_in')) {
      final l$updatedAt_in = data['updatedAt_in'];
      result$data['updatedAt_in'] = (l$updatedAt_in as List<dynamic>?)
          ?.map((e) => (e as String))
          .toList();
    }
    if (data.containsKey('updatedAt_lt')) {
      final l$updatedAt_lt = data['updatedAt_lt'];
      result$data['updatedAt_lt'] = (l$updatedAt_lt as String?);
    }
    if (data.containsKey('updatedAt_lte')) {
      final l$updatedAt_lte = data['updatedAt_lte'];
      result$data['updatedAt_lte'] = (l$updatedAt_lte as String?);
    }
    if (data.containsKey('metadata_eq')) {
      final l$metadata_eq = data['metadata_eq'];
      result$data['metadata_eq'] = (l$metadata_eq as Map<String, dynamic>?);
    }
    if (data.containsKey('metadata_exists')) {
      final l$metadata_exists = data['metadata_exists'];
      result$data['metadata_exists'] = (l$metadata_exists as bool?);
    }
    if (data.containsKey('metadata_gt')) {
      final l$metadata_gt = data['metadata_gt'];
      result$data['metadata_gt'] = (l$metadata_gt as Map<String, dynamic>?);
    }
    if (data.containsKey('metadata_gte')) {
      final l$metadata_gte = data['metadata_gte'];
      result$data['metadata_gte'] = (l$metadata_gte as Map<String, dynamic>?);
    }
    if (data.containsKey('metadata_in')) {
      final l$metadata_in = data['metadata_in'];
      result$data['metadata_in'] = (l$metadata_in as List<dynamic>?)
          ?.map((e) => (e as Map<String, dynamic>))
          .toList();
    }
    if (data.containsKey('metadata_lt')) {
      final l$metadata_lt = data['metadata_lt'];
      result$data['metadata_lt'] = (l$metadata_lt as Map<String, dynamic>?);
    }
    if (data.containsKey('metadata_lte')) {
      final l$metadata_lte = data['metadata_lte'];
      result$data['metadata_lte'] = (l$metadata_lte as Map<String, dynamic>?);
    }
    if (data.containsKey('text_eq')) {
      final l$text_eq = data['text_eq'];
      result$data['text_eq'] = (l$text_eq as String?);
    }
    if (data.containsKey('text_exists')) {
      final l$text_exists = data['text_exists'];
      result$data['text_exists'] = (l$text_exists as bool?);
    }
    if (data.containsKey('text_gt')) {
      final l$text_gt = data['text_gt'];
      result$data['text_gt'] = (l$text_gt as String?);
    }
    if (data.containsKey('text_gte')) {
      final l$text_gte = data['text_gte'];
      result$data['text_gte'] = (l$text_gte as String?);
    }
    if (data.containsKey('text_in')) {
      final l$text_in = data['text_in'];
      result$data['text_in'] =
          (l$text_in as List<dynamic>?)?.map((e) => (e as String)).toList();
    }
    if (data.containsKey('text_lt')) {
      final l$text_lt = data['text_lt'];
      result$data['text_lt'] = (l$text_lt as String?);
    }
    if (data.containsKey('text_lte')) {
      final l$text_lte = data['text_lte'];
      result$data['text_lte'] = (l$text_lte as String?);
    }
    if (data.containsKey('user_eq')) {
      final l$user_eq = data['user_eq'];
      result$data['user_eq'] = (l$user_eq as String?);
    }
    if (data.containsKey('user_exists')) {
      final l$user_exists = data['user_exists'];
      result$data['user_exists'] = (l$user_exists as bool?);
    }
    if (data.containsKey('user_gt')) {
      final l$user_gt = data['user_gt'];
      result$data['user_gt'] = (l$user_gt as String?);
    }
    if (data.containsKey('user_gte')) {
      final l$user_gte = data['user_gte'];
      result$data['user_gte'] = (l$user_gte as String?);
    }
    if (data.containsKey('user_in')) {
      final l$user_in = data['user_in'];
      result$data['user_in'] =
          (l$user_in as List<dynamic>?)?.map((e) => (e as String)).toList();
    }
    if (data.containsKey('user_lt')) {
      final l$user_lt = data['user_lt'];
      result$data['user_lt'] = (l$user_lt as String?);
    }
    if (data.containsKey('user_lte')) {
      final l$user_lte = data['user_lte'];
      result$data['user_lte'] = (l$user_lte as String?);
    }
    return Input$DocumentFilter._(result$data);
  }

  Map<String, dynamic> _$data;

  String? get $_id_eq => (_$data['_id_eq'] as String?);
  bool? get $_id_exists => (_$data['_id_exists'] as bool?);
  String? get $_id_gt => (_$data['_id_gt'] as String?);
  String? get $_id_gte => (_$data['_id_gte'] as String?);
  List<String>? get $_id_in => (_$data['_id_in'] as List<String>?);
  String? get $_id_lt => (_$data['_id_lt'] as String?);
  String? get $_id_lte => (_$data['_id_lte'] as String?);
  String? get createdAt_eq => (_$data['createdAt_eq'] as String?);
  bool? get createdAt_exists => (_$data['createdAt_exists'] as bool?);
  String? get createdAt_gt => (_$data['createdAt_gt'] as String?);
  String? get createdAt_gte => (_$data['createdAt_gte'] as String?);
  List<String>? get createdAt_in => (_$data['createdAt_in'] as List<String>?);
  String? get createdAt_lt => (_$data['createdAt_lt'] as String?);
  String? get createdAt_lte => (_$data['createdAt_lte'] as String?);
  String? get updatedAt_eq => (_$data['updatedAt_eq'] as String?);
  bool? get updatedAt_exists => (_$data['updatedAt_exists'] as bool?);
  String? get updatedAt_gt => (_$data['updatedAt_gt'] as String?);
  String? get updatedAt_gte => (_$data['updatedAt_gte'] as String?);
  List<String>? get updatedAt_in => (_$data['updatedAt_in'] as List<String>?);
  String? get updatedAt_lt => (_$data['updatedAt_lt'] as String?);
  String? get updatedAt_lte => (_$data['updatedAt_lte'] as String?);
  Map<String, dynamic>? get metadata_eq =>
      (_$data['metadata_eq'] as Map<String, dynamic>?);
  bool? get metadata_exists => (_$data['metadata_exists'] as bool?);
  Map<String, dynamic>? get metadata_gt =>
      (_$data['metadata_gt'] as Map<String, dynamic>?);
  Map<String, dynamic>? get metadata_gte =>
      (_$data['metadata_gte'] as Map<String, dynamic>?);
  List<Map<String, dynamic>>? get metadata_in =>
      (_$data['metadata_in'] as List<Map<String, dynamic>>?);
  Map<String, dynamic>? get metadata_lt =>
      (_$data['metadata_lt'] as Map<String, dynamic>?);
  Map<String, dynamic>? get metadata_lte =>
      (_$data['metadata_lte'] as Map<String, dynamic>?);
  String? get text_eq => (_$data['text_eq'] as String?);
  bool? get text_exists => (_$data['text_exists'] as bool?);
  String? get text_gt => (_$data['text_gt'] as String?);
  String? get text_gte => (_$data['text_gte'] as String?);
  List<String>? get text_in => (_$data['text_in'] as List<String>?);
  String? get text_lt => (_$data['text_lt'] as String?);
  String? get text_lte => (_$data['text_lte'] as String?);
  String? get user_eq => (_$data['user_eq'] as String?);
  bool? get user_exists => (_$data['user_exists'] as bool?);
  String? get user_gt => (_$data['user_gt'] as String?);
  String? get user_gte => (_$data['user_gte'] as String?);
  List<String>? get user_in => (_$data['user_in'] as List<String>?);
  String? get user_lt => (_$data['user_lt'] as String?);
  String? get user_lte => (_$data['user_lte'] as String?);
  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    if (_$data.containsKey('_id_eq')) {
      final l$$_id_eq = $_id_eq;
      result$data['_id_eq'] = l$$_id_eq;
    }
    if (_$data.containsKey('_id_exists')) {
      final l$$_id_exists = $_id_exists;
      result$data['_id_exists'] = l$$_id_exists;
    }
    if (_$data.containsKey('_id_gt')) {
      final l$$_id_gt = $_id_gt;
      result$data['_id_gt'] = l$$_id_gt;
    }
    if (_$data.containsKey('_id_gte')) {
      final l$$_id_gte = $_id_gte;
      result$data['_id_gte'] = l$$_id_gte;
    }
    if (_$data.containsKey('_id_in')) {
      final l$$_id_in = $_id_in;
      result$data['_id_in'] = l$$_id_in?.map((e) => e).toList();
    }
    if (_$data.containsKey('_id_lt')) {
      final l$$_id_lt = $_id_lt;
      result$data['_id_lt'] = l$$_id_lt;
    }
    if (_$data.containsKey('_id_lte')) {
      final l$$_id_lte = $_id_lte;
      result$data['_id_lte'] = l$$_id_lte;
    }
    if (_$data.containsKey('createdAt_eq')) {
      final l$createdAt_eq = createdAt_eq;
      result$data['createdAt_eq'] = l$createdAt_eq;
    }
    if (_$data.containsKey('createdAt_exists')) {
      final l$createdAt_exists = createdAt_exists;
      result$data['createdAt_exists'] = l$createdAt_exists;
    }
    if (_$data.containsKey('createdAt_gt')) {
      final l$createdAt_gt = createdAt_gt;
      result$data['createdAt_gt'] = l$createdAt_gt;
    }
    if (_$data.containsKey('createdAt_gte')) {
      final l$createdAt_gte = createdAt_gte;
      result$data['createdAt_gte'] = l$createdAt_gte;
    }
    if (_$data.containsKey('createdAt_in')) {
      final l$createdAt_in = createdAt_in;
      result$data['createdAt_in'] = l$createdAt_in?.map((e) => e).toList();
    }
    if (_$data.containsKey('createdAt_lt')) {
      final l$createdAt_lt = createdAt_lt;
      result$data['createdAt_lt'] = l$createdAt_lt;
    }
    if (_$data.containsKey('createdAt_lte')) {
      final l$createdAt_lte = createdAt_lte;
      result$data['createdAt_lte'] = l$createdAt_lte;
    }
    if (_$data.containsKey('updatedAt_eq')) {
      final l$updatedAt_eq = updatedAt_eq;
      result$data['updatedAt_eq'] = l$updatedAt_eq;
    }
    if (_$data.containsKey('updatedAt_exists')) {
      final l$updatedAt_exists = updatedAt_exists;
      result$data['updatedAt_exists'] = l$updatedAt_exists;
    }
    if (_$data.containsKey('updatedAt_gt')) {
      final l$updatedAt_gt = updatedAt_gt;
      result$data['updatedAt_gt'] = l$updatedAt_gt;
    }
    if (_$data.containsKey('updatedAt_gte')) {
      final l$updatedAt_gte = updatedAt_gte;
      result$data['updatedAt_gte'] = l$updatedAt_gte;
    }
    if (_$data.containsKey('updatedAt_in')) {
      final l$updatedAt_in = updatedAt_in;
      result$data['updatedAt_in'] = l$updatedAt_in?.map((e) => e).toList();
    }
    if (_$data.containsKey('updatedAt_lt')) {
      final l$updatedAt_lt = updatedAt_lt;
      result$data['updatedAt_lt'] = l$updatedAt_lt;
    }
    if (_$data.containsKey('updatedAt_lte')) {
      final l$updatedAt_lte = updatedAt_lte;
      result$data['updatedAt_lte'] = l$updatedAt_lte;
    }
    if (_$data.containsKey('metadata_eq')) {
      final l$metadata_eq = metadata_eq;
      result$data['metadata_eq'] = l$metadata_eq;
    }
    if (_$data.containsKey('metadata_exists')) {
      final l$metadata_exists = metadata_exists;
      result$data['metadata_exists'] = l$metadata_exists;
    }
    if (_$data.containsKey('metadata_gt')) {
      final l$metadata_gt = metadata_gt;
      result$data['metadata_gt'] = l$metadata_gt;
    }
    if (_$data.containsKey('metadata_gte')) {
      final l$metadata_gte = metadata_gte;
      result$data['metadata_gte'] = l$metadata_gte;
    }
    if (_$data.containsKey('metadata_in')) {
      final l$metadata_in = metadata_in;
      result$data['metadata_in'] = l$metadata_in?.map((e) => e).toList();
    }
    if (_$data.containsKey('metadata_lt')) {
      final l$metadata_lt = metadata_lt;
      result$data['metadata_lt'] = l$metadata_lt;
    }
    if (_$data.containsKey('metadata_lte')) {
      final l$metadata_lte = metadata_lte;
      result$data['metadata_lte'] = l$metadata_lte;
    }
    if (_$data.containsKey('text_eq')) {
      final l$text_eq = text_eq;
      result$data['text_eq'] = l$text_eq;
    }
    if (_$data.containsKey('text_exists')) {
      final l$text_exists = text_exists;
      result$data['text_exists'] = l$text_exists;
    }
    if (_$data.containsKey('text_gt')) {
      final l$text_gt = text_gt;
      result$data['text_gt'] = l$text_gt;
    }
    if (_$data.containsKey('text_gte')) {
      final l$text_gte = text_gte;
      result$data['text_gte'] = l$text_gte;
    }
    if (_$data.containsKey('text_in')) {
      final l$text_in = text_in;
      result$data['text_in'] = l$text_in?.map((e) => e).toList();
    }
    if (_$data.containsKey('text_lt')) {
      final l$text_lt = text_lt;
      result$data['text_lt'] = l$text_lt;
    }
    if (_$data.containsKey('text_lte')) {
      final l$text_lte = text_lte;
      result$data['text_lte'] = l$text_lte;
    }
    if (_$data.containsKey('user_eq')) {
      final l$user_eq = user_eq;
      result$data['user_eq'] = l$user_eq;
    }
    if (_$data.containsKey('user_exists')) {
      final l$user_exists = user_exists;
      result$data['user_exists'] = l$user_exists;
    }
    if (_$data.containsKey('user_gt')) {
      final l$user_gt = user_gt;
      result$data['user_gt'] = l$user_gt;
    }
    if (_$data.containsKey('user_gte')) {
      final l$user_gte = user_gte;
      result$data['user_gte'] = l$user_gte;
    }
    if (_$data.containsKey('user_in')) {
      final l$user_in = user_in;
      result$data['user_in'] = l$user_in?.map((e) => e).toList();
    }
    if (_$data.containsKey('user_lt')) {
      final l$user_lt = user_lt;
      result$data['user_lt'] = l$user_lt;
    }
    if (_$data.containsKey('user_lte')) {
      final l$user_lte = user_lte;
      result$data['user_lte'] = l$user_lte;
    }
    return result$data;
  }

  CopyWith$Input$DocumentFilter<Input$DocumentFilter> get copyWith =>
      CopyWith$Input$DocumentFilter(
        this,
        (i) => i,
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Input$DocumentFilter) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$$_id_eq = $_id_eq;
    final lOther$$_id_eq = other.$_id_eq;
    if (_$data.containsKey('_id_eq') != other._$data.containsKey('_id_eq')) {
      return false;
    }
    if (l$$_id_eq != lOther$$_id_eq) {
      return false;
    }
    final l$$_id_exists = $_id_exists;
    final lOther$$_id_exists = other.$_id_exists;
    if (_$data.containsKey('_id_exists') !=
        other._$data.containsKey('_id_exists')) {
      return false;
    }
    if (l$$_id_exists != lOther$$_id_exists) {
      return false;
    }
    final l$$_id_gt = $_id_gt;
    final lOther$$_id_gt = other.$_id_gt;
    if (_$data.containsKey('_id_gt') != other._$data.containsKey('_id_gt')) {
      return false;
    }
    if (l$$_id_gt != lOther$$_id_gt) {
      return false;
    }
    final l$$_id_gte = $_id_gte;
    final lOther$$_id_gte = other.$_id_gte;
    if (_$data.containsKey('_id_gte') != other._$data.containsKey('_id_gte')) {
      return false;
    }
    if (l$$_id_gte != lOther$$_id_gte) {
      return false;
    }
    final l$$_id_in = $_id_in;
    final lOther$$_id_in = other.$_id_in;
    if (_$data.containsKey('_id_in') != other._$data.containsKey('_id_in')) {
      return false;
    }
    if (l$$_id_in != null && lOther$$_id_in != null) {
      if (l$$_id_in.length != lOther$$_id_in.length) {
        return false;
      }
      for (int i = 0; i < l$$_id_in.length; i++) {
        final l$$_id_in$entry = l$$_id_in[i];
        final lOther$$_id_in$entry = lOther$$_id_in[i];
        if (l$$_id_in$entry != lOther$$_id_in$entry) {
          return false;
        }
      }
    } else if (l$$_id_in != lOther$$_id_in) {
      return false;
    }
    final l$$_id_lt = $_id_lt;
    final lOther$$_id_lt = other.$_id_lt;
    if (_$data.containsKey('_id_lt') != other._$data.containsKey('_id_lt')) {
      return false;
    }
    if (l$$_id_lt != lOther$$_id_lt) {
      return false;
    }
    final l$$_id_lte = $_id_lte;
    final lOther$$_id_lte = other.$_id_lte;
    if (_$data.containsKey('_id_lte') != other._$data.containsKey('_id_lte')) {
      return false;
    }
    if (l$$_id_lte != lOther$$_id_lte) {
      return false;
    }
    final l$createdAt_eq = createdAt_eq;
    final lOther$createdAt_eq = other.createdAt_eq;
    if (_$data.containsKey('createdAt_eq') !=
        other._$data.containsKey('createdAt_eq')) {
      return false;
    }
    if (l$createdAt_eq != lOther$createdAt_eq) {
      return false;
    }
    final l$createdAt_exists = createdAt_exists;
    final lOther$createdAt_exists = other.createdAt_exists;
    if (_$data.containsKey('createdAt_exists') !=
        other._$data.containsKey('createdAt_exists')) {
      return false;
    }
    if (l$createdAt_exists != lOther$createdAt_exists) {
      return false;
    }
    final l$createdAt_gt = createdAt_gt;
    final lOther$createdAt_gt = other.createdAt_gt;
    if (_$data.containsKey('createdAt_gt') !=
        other._$data.containsKey('createdAt_gt')) {
      return false;
    }
    if (l$createdAt_gt != lOther$createdAt_gt) {
      return false;
    }
    final l$createdAt_gte = createdAt_gte;
    final lOther$createdAt_gte = other.createdAt_gte;
    if (_$data.containsKey('createdAt_gte') !=
        other._$data.containsKey('createdAt_gte')) {
      return false;
    }
    if (l$createdAt_gte != lOther$createdAt_gte) {
      return false;
    }
    final l$createdAt_in = createdAt_in;
    final lOther$createdAt_in = other.createdAt_in;
    if (_$data.containsKey('createdAt_in') !=
        other._$data.containsKey('createdAt_in')) {
      return false;
    }
    if (l$createdAt_in != null && lOther$createdAt_in != null) {
      if (l$createdAt_in.length != lOther$createdAt_in.length) {
        return false;
      }
      for (int i = 0; i < l$createdAt_in.length; i++) {
        final l$createdAt_in$entry = l$createdAt_in[i];
        final lOther$createdAt_in$entry = lOther$createdAt_in[i];
        if (l$createdAt_in$entry != lOther$createdAt_in$entry) {
          return false;
        }
      }
    } else if (l$createdAt_in != lOther$createdAt_in) {
      return false;
    }
    final l$createdAt_lt = createdAt_lt;
    final lOther$createdAt_lt = other.createdAt_lt;
    if (_$data.containsKey('createdAt_lt') !=
        other._$data.containsKey('createdAt_lt')) {
      return false;
    }
    if (l$createdAt_lt != lOther$createdAt_lt) {
      return false;
    }
    final l$createdAt_lte = createdAt_lte;
    final lOther$createdAt_lte = other.createdAt_lte;
    if (_$data.containsKey('createdAt_lte') !=
        other._$data.containsKey('createdAt_lte')) {
      return false;
    }
    if (l$createdAt_lte != lOther$createdAt_lte) {
      return false;
    }
    final l$updatedAt_eq = updatedAt_eq;
    final lOther$updatedAt_eq = other.updatedAt_eq;
    if (_$data.containsKey('updatedAt_eq') !=
        other._$data.containsKey('updatedAt_eq')) {
      return false;
    }
    if (l$updatedAt_eq != lOther$updatedAt_eq) {
      return false;
    }
    final l$updatedAt_exists = updatedAt_exists;
    final lOther$updatedAt_exists = other.updatedAt_exists;
    if (_$data.containsKey('updatedAt_exists') !=
        other._$data.containsKey('updatedAt_exists')) {
      return false;
    }
    if (l$updatedAt_exists != lOther$updatedAt_exists) {
      return false;
    }
    final l$updatedAt_gt = updatedAt_gt;
    final lOther$updatedAt_gt = other.updatedAt_gt;
    if (_$data.containsKey('updatedAt_gt') !=
        other._$data.containsKey('updatedAt_gt')) {
      return false;
    }
    if (l$updatedAt_gt != lOther$updatedAt_gt) {
      return false;
    }
    final l$updatedAt_gte = updatedAt_gte;
    final lOther$updatedAt_gte = other.updatedAt_gte;
    if (_$data.containsKey('updatedAt_gte') !=
        other._$data.containsKey('updatedAt_gte')) {
      return false;
    }
    if (l$updatedAt_gte != lOther$updatedAt_gte) {
      return false;
    }
    final l$updatedAt_in = updatedAt_in;
    final lOther$updatedAt_in = other.updatedAt_in;
    if (_$data.containsKey('updatedAt_in') !=
        other._$data.containsKey('updatedAt_in')) {
      return false;
    }
    if (l$updatedAt_in != null && lOther$updatedAt_in != null) {
      if (l$updatedAt_in.length != lOther$updatedAt_in.length) {
        return false;
      }
      for (int i = 0; i < l$updatedAt_in.length; i++) {
        final l$updatedAt_in$entry = l$updatedAt_in[i];
        final lOther$updatedAt_in$entry = lOther$updatedAt_in[i];
        if (l$updatedAt_in$entry != lOther$updatedAt_in$entry) {
          return false;
        }
      }
    } else if (l$updatedAt_in != lOther$updatedAt_in) {
      return false;
    }
    final l$updatedAt_lt = updatedAt_lt;
    final lOther$updatedAt_lt = other.updatedAt_lt;
    if (_$data.containsKey('updatedAt_lt') !=
        other._$data.containsKey('updatedAt_lt')) {
      return false;
    }
    if (l$updatedAt_lt != lOther$updatedAt_lt) {
      return false;
    }
    final l$updatedAt_lte = updatedAt_lte;
    final lOther$updatedAt_lte = other.updatedAt_lte;
    if (_$data.containsKey('updatedAt_lte') !=
        other._$data.containsKey('updatedAt_lte')) {
      return false;
    }
    if (l$updatedAt_lte != lOther$updatedAt_lte) {
      return false;
    }
    final l$metadata_eq = metadata_eq;
    final lOther$metadata_eq = other.metadata_eq;
    if (_$data.containsKey('metadata_eq') !=
        other._$data.containsKey('metadata_eq')) {
      return false;
    }
    if (l$metadata_eq != lOther$metadata_eq) {
      return false;
    }
    final l$metadata_exists = metadata_exists;
    final lOther$metadata_exists = other.metadata_exists;
    if (_$data.containsKey('metadata_exists') !=
        other._$data.containsKey('metadata_exists')) {
      return false;
    }
    if (l$metadata_exists != lOther$metadata_exists) {
      return false;
    }
    final l$metadata_gt = metadata_gt;
    final lOther$metadata_gt = other.metadata_gt;
    if (_$data.containsKey('metadata_gt') !=
        other._$data.containsKey('metadata_gt')) {
      return false;
    }
    if (l$metadata_gt != lOther$metadata_gt) {
      return false;
    }
    final l$metadata_gte = metadata_gte;
    final lOther$metadata_gte = other.metadata_gte;
    if (_$data.containsKey('metadata_gte') !=
        other._$data.containsKey('metadata_gte')) {
      return false;
    }
    if (l$metadata_gte != lOther$metadata_gte) {
      return false;
    }
    final l$metadata_in = metadata_in;
    final lOther$metadata_in = other.metadata_in;
    if (_$data.containsKey('metadata_in') !=
        other._$data.containsKey('metadata_in')) {
      return false;
    }
    if (l$metadata_in != null && lOther$metadata_in != null) {
      if (l$metadata_in.length != lOther$metadata_in.length) {
        return false;
      }
      for (int i = 0; i < l$metadata_in.length; i++) {
        final l$metadata_in$entry = l$metadata_in[i];
        final lOther$metadata_in$entry = lOther$metadata_in[i];
        if (l$metadata_in$entry != lOther$metadata_in$entry) {
          return false;
        }
      }
    } else if (l$metadata_in != lOther$metadata_in) {
      return false;
    }
    final l$metadata_lt = metadata_lt;
    final lOther$metadata_lt = other.metadata_lt;
    if (_$data.containsKey('metadata_lt') !=
        other._$data.containsKey('metadata_lt')) {
      return false;
    }
    if (l$metadata_lt != lOther$metadata_lt) {
      return false;
    }
    final l$metadata_lte = metadata_lte;
    final lOther$metadata_lte = other.metadata_lte;
    if (_$data.containsKey('metadata_lte') !=
        other._$data.containsKey('metadata_lte')) {
      return false;
    }
    if (l$metadata_lte != lOther$metadata_lte) {
      return false;
    }
    final l$text_eq = text_eq;
    final lOther$text_eq = other.text_eq;
    if (_$data.containsKey('text_eq') != other._$data.containsKey('text_eq')) {
      return false;
    }
    if (l$text_eq != lOther$text_eq) {
      return false;
    }
    final l$text_exists = text_exists;
    final lOther$text_exists = other.text_exists;
    if (_$data.containsKey('text_exists') !=
        other._$data.containsKey('text_exists')) {
      return false;
    }
    if (l$text_exists != lOther$text_exists) {
      return false;
    }
    final l$text_gt = text_gt;
    final lOther$text_gt = other.text_gt;
    if (_$data.containsKey('text_gt') != other._$data.containsKey('text_gt')) {
      return false;
    }
    if (l$text_gt != lOther$text_gt) {
      return false;
    }
    final l$text_gte = text_gte;
    final lOther$text_gte = other.text_gte;
    if (_$data.containsKey('text_gte') !=
        other._$data.containsKey('text_gte')) {
      return false;
    }
    if (l$text_gte != lOther$text_gte) {
      return false;
    }
    final l$text_in = text_in;
    final lOther$text_in = other.text_in;
    if (_$data.containsKey('text_in') != other._$data.containsKey('text_in')) {
      return false;
    }
    if (l$text_in != null && lOther$text_in != null) {
      if (l$text_in.length != lOther$text_in.length) {
        return false;
      }
      for (int i = 0; i < l$text_in.length; i++) {
        final l$text_in$entry = l$text_in[i];
        final lOther$text_in$entry = lOther$text_in[i];
        if (l$text_in$entry != lOther$text_in$entry) {
          return false;
        }
      }
    } else if (l$text_in != lOther$text_in) {
      return false;
    }
    final l$text_lt = text_lt;
    final lOther$text_lt = other.text_lt;
    if (_$data.containsKey('text_lt') != other._$data.containsKey('text_lt')) {
      return false;
    }
    if (l$text_lt != lOther$text_lt) {
      return false;
    }
    final l$text_lte = text_lte;
    final lOther$text_lte = other.text_lte;
    if (_$data.containsKey('text_lte') !=
        other._$data.containsKey('text_lte')) {
      return false;
    }
    if (l$text_lte != lOther$text_lte) {
      return false;
    }
    final l$user_eq = user_eq;
    final lOther$user_eq = other.user_eq;
    if (_$data.containsKey('user_eq') != other._$data.containsKey('user_eq')) {
      return false;
    }
    if (l$user_eq != lOther$user_eq) {
      return false;
    }
    final l$user_exists = user_exists;
    final lOther$user_exists = other.user_exists;
    if (_$data.containsKey('user_exists') !=
        other._$data.containsKey('user_exists')) {
      return false;
    }
    if (l$user_exists != lOther$user_exists) {
      return false;
    }
    final l$user_gt = user_gt;
    final lOther$user_gt = other.user_gt;
    if (_$data.containsKey('user_gt') != other._$data.containsKey('user_gt')) {
      return false;
    }
    if (l$user_gt != lOther$user_gt) {
      return false;
    }
    final l$user_gte = user_gte;
    final lOther$user_gte = other.user_gte;
    if (_$data.containsKey('user_gte') !=
        other._$data.containsKey('user_gte')) {
      return false;
    }
    if (l$user_gte != lOther$user_gte) {
      return false;
    }
    final l$user_in = user_in;
    final lOther$user_in = other.user_in;
    if (_$data.containsKey('user_in') != other._$data.containsKey('user_in')) {
      return false;
    }
    if (l$user_in != null && lOther$user_in != null) {
      if (l$user_in.length != lOther$user_in.length) {
        return false;
      }
      for (int i = 0; i < l$user_in.length; i++) {
        final l$user_in$entry = l$user_in[i];
        final lOther$user_in$entry = lOther$user_in[i];
        if (l$user_in$entry != lOther$user_in$entry) {
          return false;
        }
      }
    } else if (l$user_in != lOther$user_in) {
      return false;
    }
    final l$user_lt = user_lt;
    final lOther$user_lt = other.user_lt;
    if (_$data.containsKey('user_lt') != other._$data.containsKey('user_lt')) {
      return false;
    }
    if (l$user_lt != lOther$user_lt) {
      return false;
    }
    final l$user_lte = user_lte;
    final lOther$user_lte = other.user_lte;
    if (_$data.containsKey('user_lte') !=
        other._$data.containsKey('user_lte')) {
      return false;
    }
    if (l$user_lte != lOther$user_lte) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$$_id_eq = $_id_eq;
    final l$$_id_exists = $_id_exists;
    final l$$_id_gt = $_id_gt;
    final l$$_id_gte = $_id_gte;
    final l$$_id_in = $_id_in;
    final l$$_id_lt = $_id_lt;
    final l$$_id_lte = $_id_lte;
    final l$createdAt_eq = createdAt_eq;
    final l$createdAt_exists = createdAt_exists;
    final l$createdAt_gt = createdAt_gt;
    final l$createdAt_gte = createdAt_gte;
    final l$createdAt_in = createdAt_in;
    final l$createdAt_lt = createdAt_lt;
    final l$createdAt_lte = createdAt_lte;
    final l$updatedAt_eq = updatedAt_eq;
    final l$updatedAt_exists = updatedAt_exists;
    final l$updatedAt_gt = updatedAt_gt;
    final l$updatedAt_gte = updatedAt_gte;
    final l$updatedAt_in = updatedAt_in;
    final l$updatedAt_lt = updatedAt_lt;
    final l$updatedAt_lte = updatedAt_lte;
    final l$metadata_eq = metadata_eq;
    final l$metadata_exists = metadata_exists;
    final l$metadata_gt = metadata_gt;
    final l$metadata_gte = metadata_gte;
    final l$metadata_in = metadata_in;
    final l$metadata_lt = metadata_lt;
    final l$metadata_lte = metadata_lte;
    final l$text_eq = text_eq;
    final l$text_exists = text_exists;
    final l$text_gt = text_gt;
    final l$text_gte = text_gte;
    final l$text_in = text_in;
    final l$text_lt = text_lt;
    final l$text_lte = text_lte;
    final l$user_eq = user_eq;
    final l$user_exists = user_exists;
    final l$user_gt = user_gt;
    final l$user_gte = user_gte;
    final l$user_in = user_in;
    final l$user_lt = user_lt;
    final l$user_lte = user_lte;
    return Object.hashAll([
      _$data.containsKey('_id_eq') ? l$$_id_eq : const {},
      _$data.containsKey('_id_exists') ? l$$_id_exists : const {},
      _$data.containsKey('_id_gt') ? l$$_id_gt : const {},
      _$data.containsKey('_id_gte') ? l$$_id_gte : const {},
      _$data.containsKey('_id_in')
          ? l$$_id_in == null
              ? null
              : Object.hashAll(l$$_id_in.map((v) => v))
          : const {},
      _$data.containsKey('_id_lt') ? l$$_id_lt : const {},
      _$data.containsKey('_id_lte') ? l$$_id_lte : const {},
      _$data.containsKey('createdAt_eq') ? l$createdAt_eq : const {},
      _$data.containsKey('createdAt_exists') ? l$createdAt_exists : const {},
      _$data.containsKey('createdAt_gt') ? l$createdAt_gt : const {},
      _$data.containsKey('createdAt_gte') ? l$createdAt_gte : const {},
      _$data.containsKey('createdAt_in')
          ? l$createdAt_in == null
              ? null
              : Object.hashAll(l$createdAt_in.map((v) => v))
          : const {},
      _$data.containsKey('createdAt_lt') ? l$createdAt_lt : const {},
      _$data.containsKey('createdAt_lte') ? l$createdAt_lte : const {},
      _$data.containsKey('updatedAt_eq') ? l$updatedAt_eq : const {},
      _$data.containsKey('updatedAt_exists') ? l$updatedAt_exists : const {},
      _$data.containsKey('updatedAt_gt') ? l$updatedAt_gt : const {},
      _$data.containsKey('updatedAt_gte') ? l$updatedAt_gte : const {},
      _$data.containsKey('updatedAt_in')
          ? l$updatedAt_in == null
              ? null
              : Object.hashAll(l$updatedAt_in.map((v) => v))
          : const {},
      _$data.containsKey('updatedAt_lt') ? l$updatedAt_lt : const {},
      _$data.containsKey('updatedAt_lte') ? l$updatedAt_lte : const {},
      _$data.containsKey('metadata_eq') ? l$metadata_eq : const {},
      _$data.containsKey('metadata_exists') ? l$metadata_exists : const {},
      _$data.containsKey('metadata_gt') ? l$metadata_gt : const {},
      _$data.containsKey('metadata_gte') ? l$metadata_gte : const {},
      _$data.containsKey('metadata_in')
          ? l$metadata_in == null
              ? null
              : Object.hashAll(l$metadata_in.map((v) => v))
          : const {},
      _$data.containsKey('metadata_lt') ? l$metadata_lt : const {},
      _$data.containsKey('metadata_lte') ? l$metadata_lte : const {},
      _$data.containsKey('text_eq') ? l$text_eq : const {},
      _$data.containsKey('text_exists') ? l$text_exists : const {},
      _$data.containsKey('text_gt') ? l$text_gt : const {},
      _$data.containsKey('text_gte') ? l$text_gte : const {},
      _$data.containsKey('text_in')
          ? l$text_in == null
              ? null
              : Object.hashAll(l$text_in.map((v) => v))
          : const {},
      _$data.containsKey('text_lt') ? l$text_lt : const {},
      _$data.containsKey('text_lte') ? l$text_lte : const {},
      _$data.containsKey('user_eq') ? l$user_eq : const {},
      _$data.containsKey('user_exists') ? l$user_exists : const {},
      _$data.containsKey('user_gt') ? l$user_gt : const {},
      _$data.containsKey('user_gte') ? l$user_gte : const {},
      _$data.containsKey('user_in')
          ? l$user_in == null
              ? null
              : Object.hashAll(l$user_in.map((v) => v))
          : const {},
      _$data.containsKey('user_lt') ? l$user_lt : const {},
      _$data.containsKey('user_lte') ? l$user_lte : const {},
    ]);
  }
}

abstract class CopyWith$Input$DocumentFilter<TRes> {
  factory CopyWith$Input$DocumentFilter(
    Input$DocumentFilter instance,
    TRes Function(Input$DocumentFilter) then,
  ) = _CopyWithImpl$Input$DocumentFilter;

  factory CopyWith$Input$DocumentFilter.stub(TRes res) =
      _CopyWithStubImpl$Input$DocumentFilter;

  TRes call({
    String? $_id_eq,
    bool? $_id_exists,
    String? $_id_gt,
    String? $_id_gte,
    List<String>? $_id_in,
    String? $_id_lt,
    String? $_id_lte,
    String? createdAt_eq,
    bool? createdAt_exists,
    String? createdAt_gt,
    String? createdAt_gte,
    List<String>? createdAt_in,
    String? createdAt_lt,
    String? createdAt_lte,
    String? updatedAt_eq,
    bool? updatedAt_exists,
    String? updatedAt_gt,
    String? updatedAt_gte,
    List<String>? updatedAt_in,
    String? updatedAt_lt,
    String? updatedAt_lte,
    Map<String, dynamic>? metadata_eq,
    bool? metadata_exists,
    Map<String, dynamic>? metadata_gt,
    Map<String, dynamic>? metadata_gte,
    List<Map<String, dynamic>>? metadata_in,
    Map<String, dynamic>? metadata_lt,
    Map<String, dynamic>? metadata_lte,
    String? text_eq,
    bool? text_exists,
    String? text_gt,
    String? text_gte,
    List<String>? text_in,
    String? text_lt,
    String? text_lte,
    String? user_eq,
    bool? user_exists,
    String? user_gt,
    String? user_gte,
    List<String>? user_in,
    String? user_lt,
    String? user_lte,
  });
}

class _CopyWithImpl$Input$DocumentFilter<TRes>
    implements CopyWith$Input$DocumentFilter<TRes> {
  _CopyWithImpl$Input$DocumentFilter(
    this._instance,
    this._then,
  );

  final Input$DocumentFilter _instance;

  final TRes Function(Input$DocumentFilter) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? $_id_eq = _undefined,
    Object? $_id_exists = _undefined,
    Object? $_id_gt = _undefined,
    Object? $_id_gte = _undefined,
    Object? $_id_in = _undefined,
    Object? $_id_lt = _undefined,
    Object? $_id_lte = _undefined,
    Object? createdAt_eq = _undefined,
    Object? createdAt_exists = _undefined,
    Object? createdAt_gt = _undefined,
    Object? createdAt_gte = _undefined,
    Object? createdAt_in = _undefined,
    Object? createdAt_lt = _undefined,
    Object? createdAt_lte = _undefined,
    Object? updatedAt_eq = _undefined,
    Object? updatedAt_exists = _undefined,
    Object? updatedAt_gt = _undefined,
    Object? updatedAt_gte = _undefined,
    Object? updatedAt_in = _undefined,
    Object? updatedAt_lt = _undefined,
    Object? updatedAt_lte = _undefined,
    Object? metadata_eq = _undefined,
    Object? metadata_exists = _undefined,
    Object? metadata_gt = _undefined,
    Object? metadata_gte = _undefined,
    Object? metadata_in = _undefined,
    Object? metadata_lt = _undefined,
    Object? metadata_lte = _undefined,
    Object? text_eq = _undefined,
    Object? text_exists = _undefined,
    Object? text_gt = _undefined,
    Object? text_gte = _undefined,
    Object? text_in = _undefined,
    Object? text_lt = _undefined,
    Object? text_lte = _undefined,
    Object? user_eq = _undefined,
    Object? user_exists = _undefined,
    Object? user_gt = _undefined,
    Object? user_gte = _undefined,
    Object? user_in = _undefined,
    Object? user_lt = _undefined,
    Object? user_lte = _undefined,
  }) =>
      _then(Input$DocumentFilter._({
        ..._instance._$data,
        if ($_id_eq != _undefined) '_id_eq': ($_id_eq as String?),
        if ($_id_exists != _undefined) '_id_exists': ($_id_exists as bool?),
        if ($_id_gt != _undefined) '_id_gt': ($_id_gt as String?),
        if ($_id_gte != _undefined) '_id_gte': ($_id_gte as String?),
        if ($_id_in != _undefined) '_id_in': ($_id_in as List<String>?),
        if ($_id_lt != _undefined) '_id_lt': ($_id_lt as String?),
        if ($_id_lte != _undefined) '_id_lte': ($_id_lte as String?),
        if (createdAt_eq != _undefined)
          'createdAt_eq': (createdAt_eq as String?),
        if (createdAt_exists != _undefined)
          'createdAt_exists': (createdAt_exists as bool?),
        if (createdAt_gt != _undefined)
          'createdAt_gt': (createdAt_gt as String?),
        if (createdAt_gte != _undefined)
          'createdAt_gte': (createdAt_gte as String?),
        if (createdAt_in != _undefined)
          'createdAt_in': (createdAt_in as List<String>?),
        if (createdAt_lt != _undefined)
          'createdAt_lt': (createdAt_lt as String?),
        if (createdAt_lte != _undefined)
          'createdAt_lte': (createdAt_lte as String?),
        if (updatedAt_eq != _undefined)
          'updatedAt_eq': (updatedAt_eq as String?),
        if (updatedAt_exists != _undefined)
          'updatedAt_exists': (updatedAt_exists as bool?),
        if (updatedAt_gt != _undefined)
          'updatedAt_gt': (updatedAt_gt as String?),
        if (updatedAt_gte != _undefined)
          'updatedAt_gte': (updatedAt_gte as String?),
        if (updatedAt_in != _undefined)
          'updatedAt_in': (updatedAt_in as List<String>?),
        if (updatedAt_lt != _undefined)
          'updatedAt_lt': (updatedAt_lt as String?),
        if (updatedAt_lte != _undefined)
          'updatedAt_lte': (updatedAt_lte as String?),
        if (metadata_eq != _undefined)
          'metadata_eq': (metadata_eq as Map<String, dynamic>?),
        if (metadata_exists != _undefined)
          'metadata_exists': (metadata_exists as bool?),
        if (metadata_gt != _undefined)
          'metadata_gt': (metadata_gt as Map<String, dynamic>?),
        if (metadata_gte != _undefined)
          'metadata_gte': (metadata_gte as Map<String, dynamic>?),
        if (metadata_in != _undefined)
          'metadata_in': (metadata_in as List<Map<String, dynamic>>?),
        if (metadata_lt != _undefined)
          'metadata_lt': (metadata_lt as Map<String, dynamic>?),
        if (metadata_lte != _undefined)
          'metadata_lte': (metadata_lte as Map<String, dynamic>?),
        if (text_eq != _undefined) 'text_eq': (text_eq as String?),
        if (text_exists != _undefined) 'text_exists': (text_exists as bool?),
        if (text_gt != _undefined) 'text_gt': (text_gt as String?),
        if (text_gte != _undefined) 'text_gte': (text_gte as String?),
        if (text_in != _undefined) 'text_in': (text_in as List<String>?),
        if (text_lt != _undefined) 'text_lt': (text_lt as String?),
        if (text_lte != _undefined) 'text_lte': (text_lte as String?),
        if (user_eq != _undefined) 'user_eq': (user_eq as String?),
        if (user_exists != _undefined) 'user_exists': (user_exists as bool?),
        if (user_gt != _undefined) 'user_gt': (user_gt as String?),
        if (user_gte != _undefined) 'user_gte': (user_gte as String?),
        if (user_in != _undefined) 'user_in': (user_in as List<String>?),
        if (user_lt != _undefined) 'user_lt': (user_lt as String?),
        if (user_lte != _undefined) 'user_lte': (user_lte as String?),
      }));
}

class _CopyWithStubImpl$Input$DocumentFilter<TRes>
    implements CopyWith$Input$DocumentFilter<TRes> {
  _CopyWithStubImpl$Input$DocumentFilter(this._res);

  TRes _res;

  call({
    String? $_id_eq,
    bool? $_id_exists,
    String? $_id_gt,
    String? $_id_gte,
    List<String>? $_id_in,
    String? $_id_lt,
    String? $_id_lte,
    String? createdAt_eq,
    bool? createdAt_exists,
    String? createdAt_gt,
    String? createdAt_gte,
    List<String>? createdAt_in,
    String? createdAt_lt,
    String? createdAt_lte,
    String? updatedAt_eq,
    bool? updatedAt_exists,
    String? updatedAt_gt,
    String? updatedAt_gte,
    List<String>? updatedAt_in,
    String? updatedAt_lt,
    String? updatedAt_lte,
    Map<String, dynamic>? metadata_eq,
    bool? metadata_exists,
    Map<String, dynamic>? metadata_gt,
    Map<String, dynamic>? metadata_gte,
    List<Map<String, dynamic>>? metadata_in,
    Map<String, dynamic>? metadata_lt,
    Map<String, dynamic>? metadata_lte,
    String? text_eq,
    bool? text_exists,
    String? text_gt,
    String? text_gte,
    List<String>? text_in,
    String? text_lt,
    String? text_lte,
    String? user_eq,
    bool? user_exists,
    String? user_gt,
    String? user_gte,
    List<String>? user_in,
    String? user_lt,
    String? user_lte,
  }) =>
      _res;
}

class Input$ConfigInput {
  factory Input$ConfigInput({
    String? avatar,
    String? backstory,
    required String description,
    Map<String, dynamic>? filter,
    bool? isPublic,
    required String job,
    String? modelName,
    required String name,
    String? openaiApiKey,
    String? systemMessage,
    double? temperature,
    double? topP,
    String? welcomeMessage,
    Map<String, dynamic>? welcomeMetadata,
  }) =>
      Input$ConfigInput._({
        if (avatar != null) r'avatar': avatar,
        if (backstory != null) r'backstory': backstory,
        r'description': description,
        if (filter != null) r'filter': filter,
        if (isPublic != null) r'isPublic': isPublic,
        r'job': job,
        if (modelName != null) r'modelName': modelName,
        r'name': name,
        if (openaiApiKey != null) r'openaiApiKey': openaiApiKey,
        if (systemMessage != null) r'systemMessage': systemMessage,
        if (temperature != null) r'temperature': temperature,
        if (topP != null) r'topP': topP,
        if (welcomeMessage != null) r'welcomeMessage': welcomeMessage,
        if (welcomeMetadata != null) r'welcomeMetadata': welcomeMetadata,
      });

  Input$ConfigInput._(this._$data);

  factory Input$ConfigInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    if (data.containsKey('avatar')) {
      final l$avatar = data['avatar'];
      result$data['avatar'] = (l$avatar as String?);
    }
    if (data.containsKey('backstory')) {
      final l$backstory = data['backstory'];
      result$data['backstory'] = (l$backstory as String?);
    }
    final l$description = data['description'];
    result$data['description'] = (l$description as String);
    if (data.containsKey('filter')) {
      final l$filter = data['filter'];
      result$data['filter'] = (l$filter as Map<String, dynamic>?);
    }
    if (data.containsKey('isPublic')) {
      final l$isPublic = data['isPublic'];
      result$data['isPublic'] = (l$isPublic as bool?);
    }
    final l$job = data['job'];
    result$data['job'] = (l$job as String);
    if (data.containsKey('modelName')) {
      final l$modelName = data['modelName'];
      result$data['modelName'] = (l$modelName as String?);
    }
    final l$name = data['name'];
    result$data['name'] = (l$name as String);
    if (data.containsKey('openaiApiKey')) {
      final l$openaiApiKey = data['openaiApiKey'];
      result$data['openaiApiKey'] = (l$openaiApiKey as String?);
    }
    if (data.containsKey('systemMessage')) {
      final l$systemMessage = data['systemMessage'];
      result$data['systemMessage'] = (l$systemMessage as String?);
    }
    if (data.containsKey('temperature')) {
      final l$temperature = data['temperature'];
      result$data['temperature'] = (l$temperature as num?)?.toDouble();
    }
    if (data.containsKey('topP')) {
      final l$topP = data['topP'];
      result$data['topP'] = (l$topP as num?)?.toDouble();
    }
    if (data.containsKey('welcomeMessage')) {
      final l$welcomeMessage = data['welcomeMessage'];
      result$data['welcomeMessage'] = (l$welcomeMessage as String?);
    }
    if (data.containsKey('welcomeMetadata')) {
      final l$welcomeMetadata = data['welcomeMetadata'];
      result$data['welcomeMetadata'] =
          (l$welcomeMetadata as Map<String, dynamic>?);
    }
    return Input$ConfigInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String? get avatar => (_$data['avatar'] as String?);
  String? get backstory => (_$data['backstory'] as String?);
  String get description => (_$data['description'] as String);
  Map<String, dynamic>? get filter =>
      (_$data['filter'] as Map<String, dynamic>?);
  bool? get isPublic => (_$data['isPublic'] as bool?);
  String get job => (_$data['job'] as String);
  String? get modelName => (_$data['modelName'] as String?);
  String get name => (_$data['name'] as String);
  String? get openaiApiKey => (_$data['openaiApiKey'] as String?);
  String? get systemMessage => (_$data['systemMessage'] as String?);
  double? get temperature => (_$data['temperature'] as double?);
  double? get topP => (_$data['topP'] as double?);
  String? get welcomeMessage => (_$data['welcomeMessage'] as String?);
  Map<String, dynamic>? get welcomeMetadata =>
      (_$data['welcomeMetadata'] as Map<String, dynamic>?);
  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    if (_$data.containsKey('avatar')) {
      final l$avatar = avatar;
      result$data['avatar'] = l$avatar;
    }
    if (_$data.containsKey('backstory')) {
      final l$backstory = backstory;
      result$data['backstory'] = l$backstory;
    }
    final l$description = description;
    result$data['description'] = l$description;
    if (_$data.containsKey('filter')) {
      final l$filter = filter;
      result$data['filter'] = l$filter;
    }
    if (_$data.containsKey('isPublic')) {
      final l$isPublic = isPublic;
      result$data['isPublic'] = l$isPublic;
    }
    final l$job = job;
    result$data['job'] = l$job;
    if (_$data.containsKey('modelName')) {
      final l$modelName = modelName;
      result$data['modelName'] = l$modelName;
    }
    final l$name = name;
    result$data['name'] = l$name;
    if (_$data.containsKey('openaiApiKey')) {
      final l$openaiApiKey = openaiApiKey;
      result$data['openaiApiKey'] = l$openaiApiKey;
    }
    if (_$data.containsKey('systemMessage')) {
      final l$systemMessage = systemMessage;
      result$data['systemMessage'] = l$systemMessage;
    }
    if (_$data.containsKey('temperature')) {
      final l$temperature = temperature;
      result$data['temperature'] = l$temperature;
    }
    if (_$data.containsKey('topP')) {
      final l$topP = topP;
      result$data['topP'] = l$topP;
    }
    if (_$data.containsKey('welcomeMessage')) {
      final l$welcomeMessage = welcomeMessage;
      result$data['welcomeMessage'] = l$welcomeMessage;
    }
    if (_$data.containsKey('welcomeMetadata')) {
      final l$welcomeMetadata = welcomeMetadata;
      result$data['welcomeMetadata'] = l$welcomeMetadata;
    }
    return result$data;
  }

  CopyWith$Input$ConfigInput<Input$ConfigInput> get copyWith =>
      CopyWith$Input$ConfigInput(
        this,
        (i) => i,
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Input$ConfigInput) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$avatar = avatar;
    final lOther$avatar = other.avatar;
    if (_$data.containsKey('avatar') != other._$data.containsKey('avatar')) {
      return false;
    }
    if (l$avatar != lOther$avatar) {
      return false;
    }
    final l$backstory = backstory;
    final lOther$backstory = other.backstory;
    if (_$data.containsKey('backstory') !=
        other._$data.containsKey('backstory')) {
      return false;
    }
    if (l$backstory != lOther$backstory) {
      return false;
    }
    final l$description = description;
    final lOther$description = other.description;
    if (l$description != lOther$description) {
      return false;
    }
    final l$filter = filter;
    final lOther$filter = other.filter;
    if (_$data.containsKey('filter') != other._$data.containsKey('filter')) {
      return false;
    }
    if (l$filter != lOther$filter) {
      return false;
    }
    final l$isPublic = isPublic;
    final lOther$isPublic = other.isPublic;
    if (_$data.containsKey('isPublic') !=
        other._$data.containsKey('isPublic')) {
      return false;
    }
    if (l$isPublic != lOther$isPublic) {
      return false;
    }
    final l$job = job;
    final lOther$job = other.job;
    if (l$job != lOther$job) {
      return false;
    }
    final l$modelName = modelName;
    final lOther$modelName = other.modelName;
    if (_$data.containsKey('modelName') !=
        other._$data.containsKey('modelName')) {
      return false;
    }
    if (l$modelName != lOther$modelName) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$openaiApiKey = openaiApiKey;
    final lOther$openaiApiKey = other.openaiApiKey;
    if (_$data.containsKey('openaiApiKey') !=
        other._$data.containsKey('openaiApiKey')) {
      return false;
    }
    if (l$openaiApiKey != lOther$openaiApiKey) {
      return false;
    }
    final l$systemMessage = systemMessage;
    final lOther$systemMessage = other.systemMessage;
    if (_$data.containsKey('systemMessage') !=
        other._$data.containsKey('systemMessage')) {
      return false;
    }
    if (l$systemMessage != lOther$systemMessage) {
      return false;
    }
    final l$temperature = temperature;
    final lOther$temperature = other.temperature;
    if (_$data.containsKey('temperature') !=
        other._$data.containsKey('temperature')) {
      return false;
    }
    if (l$temperature != lOther$temperature) {
      return false;
    }
    final l$topP = topP;
    final lOther$topP = other.topP;
    if (_$data.containsKey('topP') != other._$data.containsKey('topP')) {
      return false;
    }
    if (l$topP != lOther$topP) {
      return false;
    }
    final l$welcomeMessage = welcomeMessage;
    final lOther$welcomeMessage = other.welcomeMessage;
    if (_$data.containsKey('welcomeMessage') !=
        other._$data.containsKey('welcomeMessage')) {
      return false;
    }
    if (l$welcomeMessage != lOther$welcomeMessage) {
      return false;
    }
    final l$welcomeMetadata = welcomeMetadata;
    final lOther$welcomeMetadata = other.welcomeMetadata;
    if (_$data.containsKey('welcomeMetadata') !=
        other._$data.containsKey('welcomeMetadata')) {
      return false;
    }
    if (l$welcomeMetadata != lOther$welcomeMetadata) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$avatar = avatar;
    final l$backstory = backstory;
    final l$description = description;
    final l$filter = filter;
    final l$isPublic = isPublic;
    final l$job = job;
    final l$modelName = modelName;
    final l$name = name;
    final l$openaiApiKey = openaiApiKey;
    final l$systemMessage = systemMessage;
    final l$temperature = temperature;
    final l$topP = topP;
    final l$welcomeMessage = welcomeMessage;
    final l$welcomeMetadata = welcomeMetadata;
    return Object.hashAll([
      _$data.containsKey('avatar') ? l$avatar : const {},
      _$data.containsKey('backstory') ? l$backstory : const {},
      l$description,
      _$data.containsKey('filter') ? l$filter : const {},
      _$data.containsKey('isPublic') ? l$isPublic : const {},
      l$job,
      _$data.containsKey('modelName') ? l$modelName : const {},
      l$name,
      _$data.containsKey('openaiApiKey') ? l$openaiApiKey : const {},
      _$data.containsKey('systemMessage') ? l$systemMessage : const {},
      _$data.containsKey('temperature') ? l$temperature : const {},
      _$data.containsKey('topP') ? l$topP : const {},
      _$data.containsKey('welcomeMessage') ? l$welcomeMessage : const {},
      _$data.containsKey('welcomeMetadata') ? l$welcomeMetadata : const {},
    ]);
  }
}

abstract class CopyWith$Input$ConfigInput<TRes> {
  factory CopyWith$Input$ConfigInput(
    Input$ConfigInput instance,
    TRes Function(Input$ConfigInput) then,
  ) = _CopyWithImpl$Input$ConfigInput;

  factory CopyWith$Input$ConfigInput.stub(TRes res) =
      _CopyWithStubImpl$Input$ConfigInput;

  TRes call({
    String? avatar,
    String? backstory,
    String? description,
    Map<String, dynamic>? filter,
    bool? isPublic,
    String? job,
    String? modelName,
    String? name,
    String? openaiApiKey,
    String? systemMessage,
    double? temperature,
    double? topP,
    String? welcomeMessage,
    Map<String, dynamic>? welcomeMetadata,
  });
}

class _CopyWithImpl$Input$ConfigInput<TRes>
    implements CopyWith$Input$ConfigInput<TRes> {
  _CopyWithImpl$Input$ConfigInput(
    this._instance,
    this._then,
  );

  final Input$ConfigInput _instance;

  final TRes Function(Input$ConfigInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? avatar = _undefined,
    Object? backstory = _undefined,
    Object? description = _undefined,
    Object? filter = _undefined,
    Object? isPublic = _undefined,
    Object? job = _undefined,
    Object? modelName = _undefined,
    Object? name = _undefined,
    Object? openaiApiKey = _undefined,
    Object? systemMessage = _undefined,
    Object? temperature = _undefined,
    Object? topP = _undefined,
    Object? welcomeMessage = _undefined,
    Object? welcomeMetadata = _undefined,
  }) =>
      _then(Input$ConfigInput._({
        ..._instance._$data,
        if (avatar != _undefined) 'avatar': (avatar as String?),
        if (backstory != _undefined) 'backstory': (backstory as String?),
        if (description != _undefined && description != null)
          'description': (description as String),
        if (filter != _undefined) 'filter': (filter as Map<String, dynamic>?),
        if (isPublic != _undefined) 'isPublic': (isPublic as bool?),
        if (job != _undefined && job != null) 'job': (job as String),
        if (modelName != _undefined) 'modelName': (modelName as String?),
        if (name != _undefined && name != null) 'name': (name as String),
        if (openaiApiKey != _undefined)
          'openaiApiKey': (openaiApiKey as String?),
        if (systemMessage != _undefined)
          'systemMessage': (systemMessage as String?),
        if (temperature != _undefined) 'temperature': (temperature as double?),
        if (topP != _undefined) 'topP': (topP as double?),
        if (welcomeMessage != _undefined)
          'welcomeMessage': (welcomeMessage as String?),
        if (welcomeMetadata != _undefined)
          'welcomeMetadata': (welcomeMetadata as Map<String, dynamic>?),
      }));
}

class _CopyWithStubImpl$Input$ConfigInput<TRes>
    implements CopyWith$Input$ConfigInput<TRes> {
  _CopyWithStubImpl$Input$ConfigInput(this._res);

  TRes _res;

  call({
    String? avatar,
    String? backstory,
    String? description,
    Map<String, dynamic>? filter,
    bool? isPublic,
    String? job,
    String? modelName,
    String? name,
    String? openaiApiKey,
    String? systemMessage,
    double? temperature,
    double? topP,
    String? welcomeMessage,
    Map<String, dynamic>? welcomeMetadata,
  }) =>
      _res;
}

class Input$DocumentInput {
  factory Input$DocumentInput({
    Map<String, dynamic>? metadata,
    required String text,
  }) =>
      Input$DocumentInput._({
        if (metadata != null) r'metadata': metadata,
        r'text': text,
      });

  Input$DocumentInput._(this._$data);

  factory Input$DocumentInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    if (data.containsKey('metadata')) {
      final l$metadata = data['metadata'];
      result$data['metadata'] = (l$metadata as Map<String, dynamic>?);
    }
    final l$text = data['text'];
    result$data['text'] = (l$text as String);
    return Input$DocumentInput._(result$data);
  }

  Map<String, dynamic> _$data;

  Map<String, dynamic>? get metadata =>
      (_$data['metadata'] as Map<String, dynamic>?);
  String get text => (_$data['text'] as String);
  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    if (_$data.containsKey('metadata')) {
      final l$metadata = metadata;
      result$data['metadata'] = l$metadata;
    }
    final l$text = text;
    result$data['text'] = l$text;
    return result$data;
  }

  CopyWith$Input$DocumentInput<Input$DocumentInput> get copyWith =>
      CopyWith$Input$DocumentInput(
        this,
        (i) => i,
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Input$DocumentInput) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$metadata = metadata;
    final lOther$metadata = other.metadata;
    if (_$data.containsKey('metadata') !=
        other._$data.containsKey('metadata')) {
      return false;
    }
    if (l$metadata != lOther$metadata) {
      return false;
    }
    final l$text = text;
    final lOther$text = other.text;
    if (l$text != lOther$text) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$metadata = metadata;
    final l$text = text;
    return Object.hashAll([
      _$data.containsKey('metadata') ? l$metadata : const {},
      l$text,
    ]);
  }
}

abstract class CopyWith$Input$DocumentInput<TRes> {
  factory CopyWith$Input$DocumentInput(
    Input$DocumentInput instance,
    TRes Function(Input$DocumentInput) then,
  ) = _CopyWithImpl$Input$DocumentInput;

  factory CopyWith$Input$DocumentInput.stub(TRes res) =
      _CopyWithStubImpl$Input$DocumentInput;

  TRes call({
    Map<String, dynamic>? metadata,
    String? text,
  });
}

class _CopyWithImpl$Input$DocumentInput<TRes>
    implements CopyWith$Input$DocumentInput<TRes> {
  _CopyWithImpl$Input$DocumentInput(
    this._instance,
    this._then,
  );

  final Input$DocumentInput _instance;

  final TRes Function(Input$DocumentInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? metadata = _undefined,
    Object? text = _undefined,
  }) =>
      _then(Input$DocumentInput._({
        ..._instance._$data,
        if (metadata != _undefined)
          'metadata': (metadata as Map<String, dynamic>?),
        if (text != _undefined && text != null) 'text': (text as String),
      }));
}

class _CopyWithStubImpl$Input$DocumentInput<TRes>
    implements CopyWith$Input$DocumentInput<TRes> {
  _CopyWithStubImpl$Input$DocumentInput(this._res);

  TRes _res;

  call({
    Map<String, dynamic>? metadata,
    String? text,
  }) =>
      _res;
}

const possibleTypesMap = <String, Set<String>>{};
