# Feature Implementation Workflow

## 1. GraphQL Schema Analysis
- [ ] Review schema.graphql for relevant types and operations
- [ ] Identify query/mutation structures and required fields
- [ ] Note any special types or scalars used

## 2. Create DTOs (Data Transfer Objects)
- [ ] Create DTO classes for each type in /lib/core/data/{domain}/dtos/
- [ ] Use freezed annotation
- [ ] Include JsonKey annotations for field name mapping
- [ ] Add fromJson factory
- [ ] Create part files declarations for .freezed.dart and .g.dart

## 3. Create Domain Entities
- [ ] Create entity classes in /lib/core/domain/{domain}/entities/
- [ ] Use freezed annotation
- [ ] Add fromDto factory method
- [ ] Add fromJson factory
- [ ] Create part files declarations
- [ ] Ensure proper mapping between DTOs and entities

## 4. GraphQL Operations
- [ ] Create fragments for shared fields in /lib/graphql/backend/{domain}/fragment/
- [ ] Create queries in /lib/graphql/backend/{domain}/query/
- [ ] Create mutations in /lib/graphql/backend/{domain}/mutation/
- [ ] Use proper import syntax for fragments
- [ ] Create barrel file (domain.dart) to export all operations

## 5. Repository Layer
- [ ] Define repository interface in /lib/core/domain/{domain}/{domain}_repository.dart
- [ ] Create repository implementation in /lib/core/data/{domain}/{domain}_repository_impl.dart
- [ ] Use Either<Failure, T> for return types
- [ ] Implement proper error handling
- [ ] Add @LazySingleton annotation for DI

## 6. Code Generation
- [ ] Run build_runner to generate:
  ```bash
  ./builder_runner.sh
  ```
  - Freezed files
  - JSON serialization
  - GraphQL operation files

## 7. Best Practices
- [ ] Follow existing naming conventions
- [ ] Use proper folder structure
- [ ] Implement proper null safety
- [ ] Add proper type annotations
- [ ] Use fragments for shared GraphQL fields
- [ ] Follow DRY principle

## 8. Clean Up
- [ ] Remove any temporary files
- [ ] Update barrel files if needed
- [ ] Ensure consistent formatting
- [ ] Remove unused imports