import 'package:graphql_flutter/graphql_flutter.dart';

final getEventPaymentsQuery = gql('''
  query(
        \$user: MongoID,
        \$ticket_assignees: MongoID,
        \$skip: Int! = 0,
        \$limit: Int! = 50,
    ) {
        getPayments(
            skip: \$skip,
            limit: \$limit,
            user: \$user,
            ticket_assignees: \$ticket_assignees,
            state: { in: [captured, wiring, wired] }
            type: { eq: ticket }
        ) {
            _id,
            user,
            ticket_type,
            ticket_count,
            ticket_count_remaining,
            amount,
            ticket_discount,
            ticket_discount_amount,
            ticket_assignees_expanded {
                _id,
                name,
                email,
                username,
                new_photos_expanded {
                  bucket,
                  key,
                  url,
                },
            },
            ticket_assigned_emails
            event_expanded {
              _id
              title
              start
              currency
              cost
              new_new_photos_expanded(limit: 1) {
                  _id,
                  key,
                  bucket,
              },
              event_ticket_types {
                _id,
                title,
                cost,
                description,
              },
              address {
                street_1,
                city,
                title,
                region,
              },
            }
        }
    }
''');
