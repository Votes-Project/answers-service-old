CREATE MIGRATION m1ypswx663vv3apl6rt5xaxv3zcwtfakxz7qcmmtaqh2oj5tcviojq
    ONTO m15h5bitd2z2jkj2gk5rhqnaxtg7ynclgn2az4efkxgmpubxcy6zba
{
  ALTER TYPE default::Account {
      ALTER PROPERTY points {
          SET default := '0';
          SET TYPE std::str USING (<std::str>.points);
      };
  };
  ALTER TYPE default::AddPoints {
      ALTER PROPERTY amount {
          SET TYPE std::str USING (<std::str>.amount);
      };
  };
  ALTER TYPE default::Raffle {
      ALTER PROPERTY num_points {
          SET TYPE std::str USING (<std::str>.num_points);
      };
  };
};
