CREATE MIGRATION m1gdi6aodvf3jqkvyl5lkxnssb4sy7cow7sr53uovpeokpymbjnatq
    ONTO m1ft5uc74ehlhx6yofwr4hydkp74ztotwe6cnvu34ufoyieofqwvza
{
  ALTER TYPE default::Account {
      ALTER PROPERTY points {
          SET default := 0;
          SET TYPE std::bigint USING (<std::bigint>.points);
      };
  };
};
