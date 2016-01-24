drop table if exists hour_entry;
drop table if exists project;

create table project(
    id      serial primary key,
    name    varchar(200)
);
grant all privileges on table project to hours_user;

insert into project values (1, 'Eka projekti');
insert into project values (2, 'Toka projekti');

grant usage, select on project_id_seq to hours_user;

create table hour_entry(
    id      serial primary key,
    project_id integer references project (id),
    date    date,
    hours   real
);
grant all privileges on table hour_entry to hours_user;

grant usage, select on hour_entry_id_seq to hours_user;
