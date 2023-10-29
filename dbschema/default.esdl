using extension graphql;
module default {
  scalar type AddPointsReason extending enum<Answer, GitcoinDonation>;
  scalar type QueueId extending sequence;

  type AddPoints {
    required amount -> bigint;
    required property reason -> AddPointsReason;
  }

  type Account {
    required property context_id -> str {
       constraint exclusive;
    };
    required property points -> bigint {
      default := 0;
    };
    multi point_events -> AddPoints {
      constraint exclusive;
    };
  }

  type Question {
    property day -> datetime;
    required property question -> str;
    index on ((.day, .question));
  }

   type FlashQueue {
    required property flash_queue_id -> QueueId;
    required link question -> Question {
       constraint exclusive;
    };
  }

  type QuestionQueue {
    required property question_queue_id -> QueueId;
    required link question -> Question {
       constraint exclusive;
    };
  }

  type CommunityQueue {
    required property community_queue_id -> QueueId;
    required link question -> Question {
       constraint exclusive;
    };
  }

  type Raffle {
    required property cycle -> int32;
    required property num_points -> bigint;
    required property winner -> str;
    index on (.cycle);
  }

  type Option {
    required property option -> str;
    property details -> str;
    required num_answers -> int64 {
      default := 0;
    }
    required is_curated -> bool {
      default := false;
    };
    required single link question -> Question;
    index on (.is_curated);
    index on (.question);
 }

  type Answer {
    required property answer_num_by_voter -> int16 {
      default := 0;
    };
    required property day -> datetime;
    required single link voter -> Account;
    required single link option -> Option;
    index on ((.id, .answer_num_by_voter));
    index on ((.day, .option));
    index on ((.answer_num_by_voter, .voter));
  }
};


