CREATE MIGRATION m15h5bitd2z2jkj2gk5rhqnaxtg7ynclgn2az4efkxgmpubxcy6zba
    ONTO initial
{
  CREATE SCALAR TYPE default::AddPointsReason EXTENDING enum<Answer, GitcoinDonation>;
  CREATE TYPE default::AddPoints {
      CREATE REQUIRED PROPERTY amount: std::bigint;
      CREATE REQUIRED PROPERTY reason: default::AddPointsReason;
  };
  CREATE TYPE default::Account {
      CREATE MULTI LINK point_events: default::AddPoints {
          CREATE CONSTRAINT std::exclusive;
      };
      CREATE REQUIRED PROPERTY context_id: std::str {
          CREATE CONSTRAINT std::exclusive;
      };
      CREATE REQUIRED PROPERTY points: std::bigint {
          SET default := 0;
      };
  };
  CREATE TYPE default::Question {
      CREATE PROPERTY day: std::str;
      CREATE REQUIRED PROPERTY question: std::str;
      CREATE INDEX ON ((.day, .question));
  };
  CREATE TYPE default::Option {
      CREATE REQUIRED SINGLE LINK question: default::Question;
      CREATE INDEX ON (.question);
      CREATE REQUIRED PROPERTY is_curated: std::bool {
          SET default := false;
      };
      CREATE INDEX ON (.is_curated);
      CREATE PROPERTY details: std::str;
      CREATE REQUIRED PROPERTY num_answers: std::int64 {
          SET default := 0;
      };
      CREATE REQUIRED PROPERTY option: std::str;
  };
  CREATE TYPE default::Answer {
      CREATE REQUIRED SINGLE LINK voter: default::Account;
      CREATE REQUIRED PROPERTY answer_num_by_voter: std::int16 {
          SET default := 0;
      };
      CREATE INDEX ON ((.answer_num_by_voter, .voter));
      CREATE INDEX ON ((.id, .answer_num_by_voter));
      CREATE REQUIRED SINGLE LINK option: default::Option;
      CREATE REQUIRED PROPERTY day: std::str;
      CREATE INDEX ON ((.day, .option));
  };
  CREATE TYPE default::CommunityQueue {
      CREATE REQUIRED LINK question: default::Question {
          CREATE CONSTRAINT std::exclusive;
      };
      CREATE REQUIRED PROPERTY community_queue_id: std::str;
  };
  CREATE TYPE default::FlashQueue {
      CREATE REQUIRED LINK question: default::Question {
          CREATE CONSTRAINT std::exclusive;
      };
      CREATE REQUIRED PROPERTY flash_queue_id: std::str;
  };
  CREATE TYPE default::QuestionQueue {
      CREATE REQUIRED LINK question: default::Question {
          CREATE CONSTRAINT std::exclusive;
      };
      CREATE REQUIRED PROPERTY question_queue_id: std::str;
  };
  CREATE TYPE default::Raffle {
      CREATE REQUIRED PROPERTY cycle: std::int32;
      CREATE INDEX ON (.cycle);
      CREATE REQUIRED PROPERTY num_points: std::bigint;
      CREATE REQUIRED PROPERTY winner: std::str;
  };
};
