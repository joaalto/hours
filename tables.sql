drop table if exists project;
drop table if exists hour_entry;

create table project(
    id      serial primary key,
    name    varchar(200)
);

create table hour_entry(
    id      serial primary key,
    project_id integer references project (id),
    date    date,
    hours   real
);
