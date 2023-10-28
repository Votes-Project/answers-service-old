CREATE MIGRATION m1ft5uc74ehlhx6yofwr4hydkp74ztotwe6cnvu34ufoyieofqwvza
    ONTO m1m2o4s2at5arazcotcqsa56cywd4vst7iame3q7sgh4h26h2kyb2a
{
  ALTER TYPE default::AddPoints {
      ALTER PROPERTY amount {
          SET TYPE std::bigint USING (<std::bigint>.amount);
      };
  };
  ALTER TYPE default::Answer {
      ALTER PROPERTY day {
          SET TYPE std::datetime USING (<std::datetime>.day);
      };
  };
  ALTER TYPE default::Question {
      ALTER PROPERTY day {
          SET TYPE std::datetime USING (<std::datetime>.day);
      };
  };
  ALTER TYPE default::Raffle {
      ALTER PROPERTY num_points {
          SET TYPE std::bigint USING (<std::bigint>.num_points);
      };
  };
};
