--
-- PostgreSQL database dump
--

-- Dumped from database version 16.9 (Debian 16.9-1.pgdg120+1)
-- Dumped by pg_dump version 17.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: tuition_db_5_user
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO tuition_db_5_user;

--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA public;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: tuition_db_5_user
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO tuition_db_5_user;

--
-- Name: announcement; Type: TABLE; Schema: public; Owner: tuition_db_5_user
--

CREATE TABLE public.announcement (
    id integer NOT NULL,
    title character varying(150) NOT NULL,
    content text NOT NULL,
    date_posted timestamp without time zone,
    admin_id integer NOT NULL
);


ALTER TABLE public.announcement OWNER TO tuition_db_5_user;

--
-- Name: announcement_id_seq; Type: SEQUENCE; Schema: public; Owner: tuition_db_5_user
--

CREATE SEQUENCE public.announcement_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.announcement_id_seq OWNER TO tuition_db_5_user;

--
-- Name: announcement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tuition_db_5_user
--

ALTER SEQUENCE public.announcement_id_seq OWNED BY public.announcement.id;


--
-- Name: chapter; Type: TABLE; Schema: public; Owner: tuition_db_5_user
--

CREATE TABLE public.chapter (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    subject_id integer NOT NULL,
    date_created timestamp without time zone
);


ALTER TABLE public.chapter OWNER TO tuition_db_5_user;

--
-- Name: chapter_id_seq; Type: SEQUENCE; Schema: public; Owner: tuition_db_5_user
--

CREATE SEQUENCE public.chapter_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.chapter_id_seq OWNER TO tuition_db_5_user;

--
-- Name: chapter_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tuition_db_5_user
--

ALTER SEQUENCE public.chapter_id_seq OWNED BY public.chapter.id;


--
-- Name: live_question; Type: TABLE; Schema: public; Owner: tuition_db_5_user
--

CREATE TABLE public.live_question (
    id integer NOT NULL,
    live_test_id integer NOT NULL,
    question_number integer NOT NULL,
    question_text text NOT NULL,
    options text,
    correct_answer character varying(500),
    time_limit integer,
    date_posted timestamp without time zone
);


ALTER TABLE public.live_question OWNER TO tuition_db_5_user;

--
-- Name: live_question_id_seq; Type: SEQUENCE; Schema: public; Owner: tuition_db_5_user
--

CREATE SEQUENCE public.live_question_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.live_question_id_seq OWNER TO tuition_db_5_user;

--
-- Name: live_question_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tuition_db_5_user
--

ALTER SEQUENCE public.live_question_id_seq OWNED BY public.live_question.id;


--
-- Name: live_response; Type: TABLE; Schema: public; Owner: tuition_db_5_user
--

CREATE TABLE public.live_response (
    id integer NOT NULL,
    question_id integer NOT NULL,
    student_id integer NOT NULL,
    answer text,
    response_time double precision,
    is_correct boolean,
    points_earned double precision,
    "timestamp" timestamp without time zone
);


ALTER TABLE public.live_response OWNER TO tuition_db_5_user;

--
-- Name: live_response_id_seq; Type: SEQUENCE; Schema: public; Owner: tuition_db_5_user
--

CREATE SEQUENCE public.live_response_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.live_response_id_seq OWNER TO tuition_db_5_user;

--
-- Name: live_response_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tuition_db_5_user
--

ALTER SEQUENCE public.live_response_id_seq OWNED BY public.live_response.id;


--
-- Name: live_test; Type: TABLE; Schema: public; Owner: tuition_db_5_user
--

CREATE TABLE public.live_test (
    id integer NOT NULL,
    title character varying(200) NOT NULL,
    admin_id integer NOT NULL,
    is_active boolean,
    date_created timestamp without time zone,
    description text,
    current_question_number integer
);


ALTER TABLE public.live_test OWNER TO tuition_db_5_user;

--
-- Name: live_test_id_seq; Type: SEQUENCE; Schema: public; Owner: tuition_db_5_user
--

CREATE SEQUENCE public.live_test_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.live_test_id_seq OWNER TO tuition_db_5_user;

--
-- Name: live_test_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tuition_db_5_user
--

ALTER SEQUENCE public.live_test_id_seq OWNED BY public.live_test.id;


--
-- Name: live_test_participant; Type: TABLE; Schema: public; Owner: tuition_db_5_user
--

CREATE TABLE public.live_test_participant (
    id integer NOT NULL,
    live_test_id integer NOT NULL,
    student_id integer NOT NULL,
    total_score double precision,
    date_joined timestamp without time zone
);


ALTER TABLE public.live_test_participant OWNER TO tuition_db_5_user;

--
-- Name: live_test_participant_id_seq; Type: SEQUENCE; Schema: public; Owner: tuition_db_5_user
--

CREATE SEQUENCE public.live_test_participant_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.live_test_participant_id_seq OWNER TO tuition_db_5_user;

--
-- Name: live_test_participant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tuition_db_5_user
--

ALTER SEQUENCE public.live_test_participant_id_seq OWNED BY public.live_test_participant.id;


--
-- Name: payment; Type: TABLE; Schema: public; Owner: tuition_db_5_user
--

CREATE TABLE public.payment (
    id integer NOT NULL,
    student_id integer NOT NULL,
    amount double precision NOT NULL,
    date timestamp without time zone,
    status character varying(50)
);


ALTER TABLE public.payment OWNER TO tuition_db_5_user;

--
-- Name: payment_id_seq; Type: SEQUENCE; Schema: public; Owner: tuition_db_5_user
--

CREATE SEQUENCE public.payment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payment_id_seq OWNER TO tuition_db_5_user;

--
-- Name: payment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tuition_db_5_user
--

ALTER SEQUENCE public.payment_id_seq OWNED BY public.payment.id;


--
-- Name: student; Type: TABLE; Schema: public; Owner: tuition_db_5_user
--

CREATE TABLE public.student (
    id integer NOT NULL,
    name character varying(150) NOT NULL,
    teacher_id integer NOT NULL,
    user_id integer,
    class_level character varying(20)
);


ALTER TABLE public.student OWNER TO tuition_db_5_user;

--
-- Name: student_id_seq; Type: SEQUENCE; Schema: public; Owner: tuition_db_5_user
--

CREATE SEQUENCE public.student_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.student_id_seq OWNER TO tuition_db_5_user;

--
-- Name: student_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tuition_db_5_user
--

ALTER SEQUENCE public.student_id_seq OWNED BY public.student.id;


--
-- Name: subject; Type: TABLE; Schema: public; Owner: tuition_db_5_user
--

CREATE TABLE public.subject (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    date_created timestamp without time zone,
    admin_id integer NOT NULL
);


ALTER TABLE public.subject OWNER TO tuition_db_5_user;

--
-- Name: subject_id_seq; Type: SEQUENCE; Schema: public; Owner: tuition_db_5_user
--

CREATE SEQUENCE public.subject_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.subject_id_seq OWNER TO tuition_db_5_user;

--
-- Name: subject_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tuition_db_5_user
--

ALTER SEQUENCE public.subject_id_seq OWNED BY public.subject.id;


--
-- Name: test; Type: TABLE; Schema: public; Owner: tuition_db_5_user
--

CREATE TABLE public.test (
    id integer NOT NULL,
    title character varying(100) NOT NULL,
    description text,
    is_timed boolean,
    time_limit integer,
    content text,
    file_path character varying(255),
    date_created timestamp without time zone,
    admin_id integer NOT NULL
);


ALTER TABLE public.test OWNER TO tuition_db_5_user;

--
-- Name: test_assignment; Type: TABLE; Schema: public; Owner: tuition_db_5_user
--

CREATE TABLE public.test_assignment (
    id integer NOT NULL,
    test_id integer NOT NULL,
    student_id integer NOT NULL,
    status character varying(20),
    date_assigned timestamp without time zone,
    start_time timestamp without time zone,
    end_time timestamp without time zone,
    score double precision,
    due_date timestamp without time zone
);


ALTER TABLE public.test_assignment OWNER TO tuition_db_5_user;

--
-- Name: test_assignment_id_seq; Type: SEQUENCE; Schema: public; Owner: tuition_db_5_user
--

CREATE SEQUENCE public.test_assignment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.test_assignment_id_seq OWNER TO tuition_db_5_user;

--
-- Name: test_assignment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tuition_db_5_user
--

ALTER SEQUENCE public.test_assignment_id_seq OWNED BY public.test_assignment.id;


--
-- Name: test_id_seq; Type: SEQUENCE; Schema: public; Owner: tuition_db_5_user
--

CREATE SEQUENCE public.test_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.test_id_seq OWNER TO tuition_db_5_user;

--
-- Name: test_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tuition_db_5_user
--

ALTER SEQUENCE public.test_id_seq OWNED BY public.test.id;


--
-- Name: test_response; Type: TABLE; Schema: public; Owner: tuition_db_5_user
--

CREATE TABLE public.test_response (
    id integer NOT NULL,
    assignment_id integer NOT NULL,
    content text,
    file_path character varying(255),
    "timestamp" timestamp without time zone
);


ALTER TABLE public.test_response OWNER TO tuition_db_5_user;

--
-- Name: test_response_id_seq; Type: SEQUENCE; Schema: public; Owner: tuition_db_5_user
--

CREATE SEQUENCE public.test_response_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.test_response_id_seq OWNER TO tuition_db_5_user;

--
-- Name: test_response_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tuition_db_5_user
--

ALTER SEQUENCE public.test_response_id_seq OWNED BY public.test_response.id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: tuition_db_5_user
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    username character varying(150) NOT NULL,
    password character varying(150) NOT NULL,
    role character varying(50) NOT NULL,
    is_admin boolean
);


ALTER TABLE public."user" OWNER TO tuition_db_5_user;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: tuition_db_5_user
--

CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_id_seq OWNER TO tuition_db_5_user;

--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tuition_db_5_user
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- Name: video_lecture; Type: TABLE; Schema: public; Owner: tuition_db_5_user
--

CREATE TABLE public.video_lecture (
    id integer NOT NULL,
    title character varying(200) NOT NULL,
    description text,
    filename character varying(255),
    youtube_url character varying(255),
    date_added timestamp without time zone,
    admin_id integer NOT NULL,
    chapter_id integer
);


ALTER TABLE public.video_lecture OWNER TO tuition_db_5_user;

--
-- Name: video_lecture_id_seq; Type: SEQUENCE; Schema: public; Owner: tuition_db_5_user
--

CREATE SEQUENCE public.video_lecture_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.video_lecture_id_seq OWNER TO tuition_db_5_user;

--
-- Name: video_lecture_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tuition_db_5_user
--

ALTER SEQUENCE public.video_lecture_id_seq OWNED BY public.video_lecture.id;


--
-- Name: announcement id; Type: DEFAULT; Schema: public; Owner: tuition_db_5_user
--

ALTER TABLE ONLY public.announcement ALTER COLUMN id SET DEFAULT nextval('public.announcement_id_seq'::regclass);


--
-- Name: chapter id; Type: DEFAULT; Schema: public; Owner: tuition_db_5_user
--

ALTER TABLE ONLY public.chapter ALTER COLUMN id SET DEFAULT nextval('public.chapter_id_seq'::regclass);


--
-- Name: live_question id; Type: DEFAULT; Schema: public; Owner: tuition_db_5_user
--

ALTER TABLE ONLY public.live_question ALTER COLUMN id SET DEFAULT nextval('public.live_question_id_seq'::regclass);


--
-- Name: live_response id; Type: DEFAULT; Schema: public; Owner: tuition_db_5_user
--

ALTER TABLE ONLY public.live_response ALTER COLUMN id SET DEFAULT nextval('public.live_response_id_seq'::regclass);


--
-- Name: live_test id; Type: DEFAULT; Schema: public; Owner: tuition_db_5_user
--

ALTER TABLE ONLY public.live_test ALTER COLUMN id SET DEFAULT nextval('public.live_test_id_seq'::regclass);


--
-- Name: live_test_participant id; Type: DEFAULT; Schema: public; Owner: tuition_db_5_user
--

ALTER TABLE ONLY public.live_test_participant ALTER COLUMN id SET DEFAULT nextval('public.live_test_participant_id_seq'::regclass);


--
-- Name: payment id; Type: DEFAULT; Schema: public; Owner: tuition_db_5_user
--

ALTER TABLE ONLY public.payment ALTER COLUMN id SET DEFAULT nextval('public.payment_id_seq'::regclass);


--
-- Name: student id; Type: DEFAULT; Schema: public; Owner: tuition_db_5_user
--

ALTER TABLE ONLY public.student ALTER COLUMN id SET DEFAULT nextval('public.student_id_seq'::regclass);


--
-- Name: subject id; Type: DEFAULT; Schema: public; Owner: tuition_db_5_user
--

ALTER TABLE ONLY public.subject ALTER COLUMN id SET DEFAULT nextval('public.subject_id_seq'::regclass);


--
-- Name: test id; Type: DEFAULT; Schema: public; Owner: tuition_db_5_user
--

ALTER TABLE ONLY public.test ALTER COLUMN id SET DEFAULT nextval('public.test_id_seq'::regclass);


--
-- Name: test_assignment id; Type: DEFAULT; Schema: public; Owner: tuition_db_5_user
--

ALTER TABLE ONLY public.test_assignment ALTER COLUMN id SET DEFAULT nextval('public.test_assignment_id_seq'::regclass);


--
-- Name: test_response id; Type: DEFAULT; Schema: public; Owner: tuition_db_5_user
--

ALTER TABLE ONLY public.test_response ALTER COLUMN id SET DEFAULT nextval('public.test_response_id_seq'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: tuition_db_5_user
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- Name: video_lecture id; Type: DEFAULT; Schema: public; Owner: tuition_db_5_user
--

ALTER TABLE ONLY public.video_lecture ALTER COLUMN id SET DEFAULT nextval('public.video_lecture_id_seq'::regclass);


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: tuition_db_5_user
--

COPY public.alembic_version (version_num) FROM stdin;
09df1e232a9a
\.


--
-- Data for Name: announcement; Type: TABLE DATA; Schema: public; Owner: tuition_db_5_user
--

COPY public.announcement (id, title, content, date_posted, admin_id) FROM stdin;
5	Use Mic to Write Short and Long Answers🎙️	Don't manually type your answers	2025-05-18 07:42:26.042902	1
\.


--
-- Data for Name: chapter; Type: TABLE DATA; Schema: public; Owner: tuition_db_5_user
--

COPY public.chapter (id, name, description, subject_id, date_created) FROM stdin;
1	Life Processes		1	2025-04-05 10:58:03.300454
2	Real Numbers		2	2025-04-12 06:04:25.44254
3	Motion		3	2025-04-12 10:33:01.459874
4	Polynomials 		2	2025-04-12 10:35:18.749074
\.


--
-- Data for Name: live_question; Type: TABLE DATA; Schema: public; Owner: tuition_db_5_user
--

COPY public.live_question (id, live_test_id, question_number, question_text, options, correct_answer, time_limit, date_posted) FROM stdin;
\.


--
-- Data for Name: live_response; Type: TABLE DATA; Schema: public; Owner: tuition_db_5_user
--

COPY public.live_response (id, question_id, student_id, answer, response_time, is_correct, points_earned, "timestamp") FROM stdin;
\.


--
-- Data for Name: live_test; Type: TABLE DATA; Schema: public; Owner: tuition_db_5_user
--

COPY public.live_test (id, title, admin_id, is_active, date_created, description, current_question_number) FROM stdin;
1	Live Test Sample 1	1	t	2025-05-26 11:31:04.463343	Sample 1	0
\.


--
-- Data for Name: live_test_participant; Type: TABLE DATA; Schema: public; Owner: tuition_db_5_user
--

COPY public.live_test_participant (id, live_test_id, student_id, total_score, date_joined) FROM stdin;
\.


--
-- Data for Name: payment; Type: TABLE DATA; Schema: public; Owner: tuition_db_5_user
--

COPY public.payment (id, student_id, amount, date, status) FROM stdin;
\.


--
-- Data for Name: student; Type: TABLE DATA; Schema: public; Owner: tuition_db_5_user
--

COPY public.student (id, name, teacher_id, user_id, class_level) FROM stdin;
12	Komal 	4	\N	\N
13	Gurleen	4	\N	\N
28	abc	1	51	\N
29	def	1	52	\N
27	Freya	1	50	Class 9
26	Diya	1	49	Class 9
24	Tamanna	4	47	Class 9
18	Greesha	4	39	Class 9
21	Ekam	1	42	Class 10
23	Ravneet	1	44	Class 10
17	Samiha	4	37	Class 10
\.


--
-- Data for Name: subject; Type: TABLE DATA; Schema: public; Owner: tuition_db_5_user
--

COPY public.subject (id, name, description, date_created, admin_id) FROM stdin;
1	Biology		2025-04-05 07:47:30.864748	1
2	Mathematics 		2025-04-12 06:03:08.334967	4
3	Physics (Class 9)		2025-04-12 10:32:47.269303	4
\.


--
-- Data for Name: test; Type: TABLE DATA; Schema: public; Owner: tuition_db_5_user
--

COPY public.test (id, title, description, is_timed, time_limit, content, file_path, date_created, admin_id) FROM stdin;
9	Chapter Light Test 1	Reflection of Light, Mirror formula and Refractive Index	t	60	1.\tWhich of the following is true about a plane mirror?\r\nA) It forms a real and inverted image\r\nB) It forms a virtual and erect image\r\nC) It forms a magnified image\r\nD) It forms a real and erect image\r\n\r\n2.\tThe angle of incidence is equal to the angle of reflection. This is stated in:\r\nA) Newton’s First Law\r\nB) Law of Refraction\r\nC) First Law of Reflection\r\nD) Second Law of Reflection\r\n\r\n3.\tWhen light passes from air into glass, it:\r\nA) Speeds up\r\nB) Slows down\r\nC) Does not change speed\r\nD) Is reflected completely\r\n\r\n4.\tThe image formed by a concave mirror is real, inverted, and the same size as the object when the object is placed at:\r\nA) Focus\r\nB) Infinity\r\nC) Centre of curvature\r\nD) Between focus and pole\r\n\r\n5.\tThe unit of refractive index is:\r\nA) m/s\r\nB) No unit\r\nC) Dioptre\r\nD) Radian\r\n\r\n6.\tIf the refractive index of water with respect to air is 1.33, it means:\r\nA) Light travels faster in water than air\r\nB) Light travels 1.33 times faster in air than in water\r\nC) Water reflects all the light\r\nD) Water absorbs all the light\r\n\r\n7.\tWhich mirror is used in rearview mirrors of vehicles?\r\nA) Concave mirror\r\nB) Plane mirror\r\nC) Convex mirror\r\nD) None of these\r\n\r\n8.\tThe refractive index of glass is more than that of air. This means:\r\nA) Glass is optically denser\r\nB) Glass is optically rarer\r\nC) Glass and air have the same optical density\r\nD) Light will not bend in glass\r\n\r\n9.\tWhat happens when light is incident normally on the surface of separation between two media?\r\nA) It bends towards the normal\r\nB) It bends away from the normal\r\nC) It passes without any deviation\r\nD) It gets reflected\r\n\r\n10.\tWhich of the following statements is correct?\r\nA) Refractive index depends only on the wavelength of light\r\nB) Refractive index is the same for all materials\r\nC) Refractive index indicates how much the light bends\r\nD) Refractive index is always greater than 1\r\n\r\n11.\tIf the speed of light in a medium is 2 × 10⁸ m/s, what is the refractive index of the medium (speed of light in vacuum = 3 × 10⁸ m/s)?\r\nA) 1.33\r\nB) 1.5\r\nC) 0.67\r\nD) 2\r\n\r\n12.\tA light ray strikes a plane mirror at an angle of 40°. What is the angle of reflection?\r\nA) 50°\r\nB) 90°\r\nC) 40°\r\nD) 80°\r\n\r\n13.\tRefractive index of glass with respect to air is 1.5. What is the speed of light in glass (speed of light in vacuum = 3 × 10⁸ m/s)?\r\nA) 4.5 × 10⁸ m/s\r\nB) 2 × 10⁸ m/s\r\nC) 1.5 × 10⁸ m/s\r\nD) 3.5 × 10⁸ m/s\r\n\r\n14.\tA ray of light is incident at 60° to the normal on a plane mirror. What is the angle between the incident and reflected ray?\r\nA) 60°\r\nB) 90°\r\nC) 120°\r\nD) 30°\r\n\r\n15.\tIf the refractive index of medium A with respect to B is 1.25, then the refractive index of B with respect to A is:\r\nA) 1.25\r\nB) 0.8\r\nC) 0.5\r\nD) 2\r\n\r\n16. A concave mirror has a focal length of 15 cm. An object is placed 30 cm in front of the mirror.\r\nFind: The position and nature of the image.\r\n\r\n17. An object is placed 10 cm from a concave mirror of focal length 15 cm.\r\nFind: The position of the image.\r\n\r\n18.  A convex mirror has a focal length of 20 cm. An object is placed 40 cm in front of it.\r\nFind: The position and nature of the image.\r\n\r\n19. A concave mirror forms a real image 20 cm in front of the mirror when the object is placed 60 cm in front of it.\r\nFind: The focal length of the mirror.\r\n\r\n20. An object is placed 25 cm in front of a convex mirror. The image is formed 10 cm behind the mirror.\r\nFind: The focal length of the mirror.\r\n\r\n\r\n\r\n	\N	2025-05-10 06:19:39.270859	1
10	Chapter Motion - Test 1	Full Chapter	t	60	1. Which of the following is a scalar quantity?\r\n\r\nA) Displacement\r\nB) Velocity\r\nC) Acceleration\r\nD) Speed\r\n\r\n2. The SI unit of velocity is:\r\n\r\nA) km/h\r\nB) m/s\r\nC) cm/s\r\nD) m/h\r\n\r\n3. A body is said to be in uniform motion if it:\r\n\r\nA) Moves with constant acceleration\r\nB) Moves along a circular path\r\nC) Covers equal distances in equal intervals of time\r\nD) Changes direction continuously\r\n\r\n4. Displacement can be zero when:\r\n\r\nA) Only the starting point is known\r\nB) The object returns to its initial position\r\nC) The object is stationary\r\nD) Distance is also zero\r\n\r\n5. If a car travels 60 km in 2 hours, its average speed is:\r\n\r\nA) 120 km/h\r\nB) 30 km/h\r\nC) 60 km/h\r\nD) 90 km/h\r\n\r\n6. Which of the following is a vector quantity?\r\n\r\nA) Distance\r\nB) Displacement\r\nC) Speed\r\nD) Time\r\n\r\n7. What does the slope of a distance-time graph represent?\r\n\r\nA) Acceleration\r\nB) Speed\r\nC) Time\r\nD) Displacement\r\n\r\n8. If the velocity of a body changes from 20 m/s to 40 m/s in 5 seconds, its acceleration is:\r\n\r\nA) 4 m/s²\r\nB) 2 m/s²\r\nC) 10 m/s²\r\nD) 5 m/s²\r\n\r\n9. The area under a velocity-time graph gives:\r\n\r\nA) Acceleration\r\nB) Speed\r\nC) Displacement\r\nD) Time\r\n\r\n10. An object moving with a constant velocity has:\r\n\r\nA) Constant speed but changing direction\r\nB) Constant acceleration\r\nC) No acceleration\r\nD) Increasing speed\r\n\r\n11. A body moves in a circular path with uniform speed. Its velocity:\r\n\r\nA) Is constant\r\nB) Changes due to change in direction\r\nC) Is zero\r\nD) Increases continuously\r\n\r\n12. If a vehicle increases its speed from 36 km/h to 72 km/h in 10 seconds, the acceleration is:\r\n\r\nA) 2 m/s²\r\nB) 1 m/s²\r\nC) 3.6 m/s²\r\nD) 5 m/s²\r\n\r\n13. Which of these is not an equation of motion?\r\n\r\nA) v = u + at\r\nB) s = ut + ½ at²\r\nC) v² = u² + 2as\r\nD) s = vt + ½ at²\r\n\r\n14. What is the average speed of a car that travels 100 km in 2 hours and 50 km in 1 hour?\r\n\r\nA) 50 km/h\r\nB) 60 km/h\r\nC) 62.5 km/h\r\nD) 75 km/h\r\n\r\n15. A body is said to be in non-uniform motion when it:\r\n\r\nA) Moves with constant velocity\r\nB) Covers equal distances in equal time\r\nC) Changes its speed or direction or both\r\nD) Remains at rest\r\n\r\n16. A car starts from rest and accelerates at 2 \\, m/s^2. What will be its velocity after 10 seconds?\r\n\r\n17 . An object is moving with an initial velocity of 5 \\, m/s and has an acceleration of 3 \\, m/s^2. What distance will it cover in 4 seconds?\r\n\r\n18.   A bike increases its speed from 20 \\, m/s to 30 \\, m/s in 5 seconds. Find its acceleration.\r\n\r\n19. A car traveling at 25 \\, m/s comes to rest in 10 seconds. Find the retardation and distance covered.\r\n\r\n20. An object starts from rest and covers a distance of 100 m in 5 seconds. Find the acceleration.\r\n\r\n\r\n\r\n	\N	2025-05-10 06:33:57.98877	1
12	Answer Key (Motion) Class 9 	Full Answer Key	f	\N	\r\nTest Content Preview ( Total Marks -> 30)\r\n1. Which of the following is a scalar quantity?\r\n\r\nA) Displacement\r\nB) Velocity\r\nC) Acceleration\r\nD) Speed\r\nAnswer: D\r\n\r\n⸻\r\n\r\n2. The SI unit of velocity is:\r\n\r\nA) km/h\r\nB) m/s\r\nC) cm/s\r\nD) m/h\r\nAnswer: B\r\n\r\n⸻\r\n\r\n3. A body is said to be in uniform motion if it:\r\n\r\nA) Moves with constant acceleration\r\nB) Moves along a circular path\r\nC) Covers equal distances in equal intervals of time\r\nD) Changes direction continuously\r\nAnswer: C\r\n\r\n⸻\r\n\r\n4. Displacement can be zero when:\r\n\r\nA) Only the starting point is known\r\nB) The object returns to its initial position\r\nC) The object is stationary\r\nD) Distance is also zero\r\nAnswer: B\r\n\r\n⸻\r\n\r\n5. If a car travels 60 km in 2 hours, its average speed is:\r\n\r\nA) 120 km/h\r\nB) 30 km/h\r\nC) 60 km/h\r\nD) 90 km/h\r\nAnswer: B\r\n\r\n⸻\r\n\r\n6. Which of the following is a vector quantity?\r\n\r\nA) Distance\r\nB) Displacement\r\nC) Speed\r\nD) Time\r\nAnswer: B\r\n\r\n⸻\r\n\r\n7. What does the slope of a distance-time graph represent?\r\n\r\nA) Acceleration\r\nB) Speed\r\nC) Time\r\nD) Displacement\r\nAnswer: B\r\n\r\n⸻\r\n\r\n8. If the velocity of a body changes from 20 m/s to 40 m/s in 5 seconds, its acceleration is:\r\n\r\nA) 4 m/s²\r\nB) 2 m/s²\r\nC) 10 m/s²\r\nD) 5 m/s²\r\nAnswer: A\r\n\r\n⸻\r\n\r\n9. The area under a velocity-time graph gives:\r\n\r\nA) Acceleration\r\nB) Speed\r\nC) Displacement\r\nD) Time\r\nAnswer: C\r\n\r\n⸻\r\n\r\n10. An object moving with a constant velocity has:\r\n\r\nA) Constant speed but changing direction\r\nB) Constant acceleration\r\nC) No acceleration\r\nD) Increasing speed\r\nAnswer: C\r\n\r\n⸻\r\n\r\n11. A body moves in a circular path with uniform speed. Its velocity:\r\n\r\nA) Is constant\r\nB) Changes due to change in direction\r\nC) Is zero\r\nD) Increases continuously\r\nAnswer: B\r\n\r\n⸻\r\n\r\n12. If a vehicle increases its speed from 36 km/h to 72 km/h in 10 seconds, the acceleration is:\r\n\r\nA) 2 m/s²\r\nB) 1 m/s²\r\nC) 3.6 m/s²\r\nD) 5 m/s²\r\nAnswer: A\r\n(Convert speeds to m/s first: 10 m/s to 20 m/s → (20 - 10)/10 = 1 m/s²)\r\n\r\n⸻\r\n\r\n13. Which of these is not an equation of motion?\r\n\r\nA) v = u + at\r\nB) s = ut + ½ at²\r\nC) v² = u² + 2as\r\nD) s = vt + ½ at²\r\nAnswer: D\r\n\r\n⸻\r\n\r\n14. What is the average speed of a car that travels 100 km in 2 hours and 50 km in 1 hour?\r\n\r\nA) 50 km/h\r\nB) 60 km/h\r\nC) 62.5 km/h\r\nD) 75 km/h\r\nAnswer: A\r\n(Total distance = 150 km; Total time = 3 h → 150/3 = 50 km/h)\r\n\r\n⸻\r\n\r\n15. A body is said to be in non-uniform motion when it:\r\n\r\nA) Moves with constant velocity\r\nB) Covers equal distances in equal time\r\nC) Changes its speed or direction or both\r\nD) Remains at rest\r\nAnswer: C\r\n\r\n16. 1. A car starts from rest and accelerates at 2 \\, m/s^2. What will be its velocity after 10 seconds?\r\nAns. 20m/s\r\n\r\n17.  An object is moving with an initial velocity of 5 \\, m/s and has an acceleration of 3 \\, m/s^2. What distance will it cover in 4 seconds?\r\nAns. 44m\r\n\r\n18.  A bike increases its speed from 20 \\, m/s to 30 \\, m/s in 5 seconds. Find its acceleration.\r\nAns. 2m/s^2\r\n\r\n19. A car traveling at 25 \\, m/s comes to rest in 10 seconds. Find the retardation and distance covered.\r\nAns. Retardation = -2.5m/s^2 and distance= 125m\r\n\r\n20. An object starts from rest and covers a distance of 100 m in 5 seconds. Find the acceleration.\r\nAns. Acceleration = 8m/s^2\r\n	\N	2025-05-10 08:05:37.955498	1
24	Class IX Science – Chapter: The Fundamental Unit of Life (Cells)	Maximum Marks: 70\r\nTime: 3 Hours\r\n	t	180	Section A – Multiple Choice Questions (1 mark each)\r\n\r\n(Attempt all questions)\r\n[1 × 10 = 10 Marks]\r\n 1. The structural and functional unit of life is:\r\na) Tissue\r\nb) Organ\r\nc) Cell\r\nd) Organ System\r\n 2. The outermost covering of a plant cell is:\r\na) Plasma membrane\r\nb) Cell wall\r\nc) Cytoplasm\r\nd) Nucleus\r\n 3. Which of the following cell organelles is known as the “powerhouse” of the cell?\r\na) Ribosome\r\nb) Golgi apparatus\r\nc) Mitochondria\r\nd) Lysosome\r\n 4. The function of ribosomes is to:\r\na) Perform respiration\r\nb) Synthesize proteins\r\nc) Provide structural support\r\nd) Package materials\r\n 5. The jelly-like substance present inside the cell is called:\r\na) Nucleoplasm\r\nb) Protoplasm\r\nc) Cytoplasm\r\nd) Cell sap\r\n 6. Which organelle is responsible for packaging and transport of materials?\r\na) Lysosome\r\nb) Mitochondria\r\nc) Endoplasmic Reticulum\r\nd) Golgi apparatus\r\n 7. Cell wall is absent in:\r\na) Fungi\r\nb) Bacteria\r\nc) Plants\r\nd) Animals\r\n 8. The control center of the cell is:\r\na) Mitochondria\r\nb) Ribosome\r\nc) Nucleus\r\nd) Chloroplast\r\n 9. The shrinkage of cytoplasm from the cell wall under hypertonic solution is:\r\na) Diffusion\r\nb) Osmosis\r\nc) Plasmolysis\r\nd) Active transport\r\n 10. Which cell organelle is present only in plant cells and is responsible for photosynthesis?\r\na) Mitochondria\r\nb) Nucleus\r\nc) Chloroplast\r\nd) Ribosome\r\n\r\n⸻\r\n\r\nSection B – Assertion and Reason Type Questions (2 marks each)\r\n\r\n(Attempt all questions)\r\n[2 × 5 = 10 Marks]\r\nChoose the correct option:\r\na) Both A and R are true and R is the correct explanation of A.\r\nb) Both A and R are true but R is not the correct explanation of A.\r\nc) A is true but R is false.\r\nd) A is false but R is true.\r\n \r\n11. Assertion (A): Plant cells have large central vacuoles.\r\nReason (R): Vacuoles help in the storage of waste material and maintaining turgidity.\r\n \r\n12. Assertion (A): Lysosomes are called suicide bags of the cell.\r\nReason (R): They digest the worn-out organelles and foreign materials using digestive enzymes.\r\n \r\n13. Assertion (A): All living organisms are composed of cells.\r\nReason (R): Cells perform different functions and are the building blocks of life.\r\n \r\n14. Assertion (A): Plasma membrane is selectively permeable.\r\nReason (R): It allows the movement of all substances freely.\r\n \r\n15. Assertion (A): Mitochondria are double membrane-bound organelles.\r\nReason (R): They are found only in plant cells.\r\n\r\n⸻\r\n\r\nSection C – Short Answer Questions (3 marks each)\r\n\r\n(Answer any five)\r\n[3 × 5 = 15 Marks]\r\n 16. Differentiate between prokaryotic and eukaryotic cells.\r\n 17. Explain the function of the plasma membrane.\r\n 18. What are the differences between plant and animal cells?\r\n 19. Describe the structure and function of the nucleus.\r\n 20. What is osmosis? Give an example.\r\n 21. What are plastids? Name its types and functions.\r\n 22. Write a short note on the Endoplasmic Reticulum (ER) and its types.\r\n\r\n⸻\r\n\r\nSection D – Short Answer Questions (5 marks each)\r\n\r\n(Answer any 3 questions)\r\n[5 × 3 = 15 Marks]\r\n 23. Draw a labeled diagram of a plant cell and explain any two parts.\r\n 24. Describe the fluid mosaic model of the plasma membrane.\r\n 25. Explain the process of plasmolysis with the help of a diagram.\r\n 26. Describe the structure and function of mitochondria. Why are they called the powerhouse of the cell?\r\n\r\n⸻\r\n\r\nSection E – Case Study Based/Value-Based Question (10 marks)\r\n\r\n(Attempt the following question)\r\n 27. Read the following passage and answer the questions below:\r\nA student put some raisins in water for a few hours. She observed that the raisins had swelled up. She then placed the swollen raisins in concentrated sugar solution. After some time, the raisins shrunk back to their original size.\r\n\r\na) What scientific process is responsible for the swelling of raisins? (2)\r\nb) What happens to the water concentration inside and outside the raisin during the swelling? (2)\r\nc) Why did the raisins shrink in sugar solution? (2)\r\nd) What would happen if raisins are placed in salt solution instead of sugar solution? (2)\r\ne) Name two other real-life situations where osmosis occurs. (2)\r\n\r\n⸻\r\n	\N	2025-05-18 07:09:54.990538	1
30	Testing mic 1	Ackncsjnvsjnvs	t	60	Bcajbwfjbcsjgfsjbdjbfsjfbsjfbsjgfjsbvbejfbejfbjdv jdvbjebjvbsjvbjsbbv	\N	2025-05-18 16:57:43.694913	4
31	Class IX Science – Chapter: The Fundamental Unit of Life (Cells)	Answer Key	f	\N	### **Answer Key**\r\n\r\n---\r\n\r\n### **Section A – Multiple Choice Questions (1 mark each)**\r\n\r\n1. **c) Cell**\r\n2. **b) Cell wall**\r\n3. **c) Mitochondria**\r\n4. **b) Synthesize proteins**\r\n5. **c) Cytoplasm**\r\n6. **d) Golgi apparatus**\r\n7. **d) Animals**\r\n8. **c) Nucleus**\r\n9. **c) Plasmolysis**\r\n10. **c) Chloroplast**\r\n\r\n---\r\n\r\n### **Section B – Assertion and Reason (2 marks each)**\r\n\r\n11. **a)** Both A and R are true and R is the correct explanation of A.\r\n    → Plant cells have large central vacuoles which store waste and help maintain turgidity by exerting pressure against the cell wall.\r\n\r\n12. **a)** Both A and R are true and R is the correct explanation of A.\r\n    → Lysosomes contain hydrolytic enzymes that digest worn-out cell parts, which is why they're called suicide bags.\r\n\r\n13. **a)** Both A and R are true and R is the correct explanation of A.\r\n    → All living organisms are made of cells which perform essential life functions.\r\n\r\n14. **c)** A is true but R is false.\r\n    → The plasma membrane is selectively permeable but **does not** allow *all* substances to move freely—it regulates entry and exit.\r\n\r\n15. **c)** A is true but R is false.\r\n    → Mitochondria are double membrane-bound, but they are found in both plant and animal cells.\r\n\r\n---\r\n\r\n### **Section C – Short Answer Questions (3 marks each)**\r\n\r\n**(Any 5 to be answered)**\r\n\r\n16. **Difference between Prokaryotic and Eukaryotic Cells**\r\n\r\n* *Prokaryotic:* No nucleus, small and simple (e.g., bacteria)\r\n* *Eukaryotic:* Have nucleus, complex and larger (e.g., plant/animal cells)\r\n* Prokaryotes lack membrane-bound organelles; eukaryotes possess them.\r\n\r\n---\r\n\r\n17. **Function of the Plasma Membrane**\r\n\r\n* Acts as a barrier separating the internal contents from the external environment.\r\n* Regulates the movement of substances in and out (selectively permeable).\r\n* Maintains homeostasis within the cell.\r\n\r\n---\r\n\r\n18. **Difference Between Plant and Animal Cells**\r\n\r\n* *Cell wall:* Present in plant, absent in animal\r\n* *Chloroplasts:* Present in plant, absent in animal\r\n* *Vacuole:* Large central in plant, small or absent in animal\r\n* Animal cells have centrioles; plant cells usually don’t.\r\n\r\n---\r\n\r\n19. **Structure and Function of the Nucleus**\r\n\r\n* Surrounded by nuclear membrane, contains nucleoplasm, nucleolus, and chromatin.\r\n* Controls cell activities, contains genetic material (DNA), and regulates cell division.\r\n\r\n---\r\n\r\n20. **What is Osmosis? Give an Example.**\r\n\r\n* Movement of water molecules from a region of high water concentration to low concentration through a semipermeable membrane.\r\n* *Example:* Absorption of water by root hairs in plants.\r\n\r\n---\r\n\r\n21. **Plastids: Types and Functions**\r\n\r\n* Organelles found in plant cells.\r\n* *Types:* Chloroplast (photosynthesis), Chromoplast (color pigments), Leucoplast (storage of starch/lipids).\r\n* They support processes like food synthesis and storage.\r\n\r\n---\r\n\r\n22. **Endoplasmic Reticulum (ER) and Its Types**\r\n\r\n* Network of membranes within cytoplasm.\r\n* *Rough ER:* With ribosomes, protein synthesis.\r\n* *Smooth ER:* No ribosomes, lipid synthesis and detoxification.\r\n\r\n---\r\n\r\n### **Section D – Short Answer Questions (5 marks each)**\r\n\r\n**(Any 3 to be answered)**\r\n\r\n23. **Diagram of a Plant Cell with Explanation (any two parts)**\r\n\r\n* **\\[Include a labeled diagram with parts like cell wall, membrane, nucleus, chloroplast, vacuole, etc.]**\r\n* *Example explanation:*\r\n\r\n  * **Chloroplast:** Contains chlorophyll; site of photosynthesis.\r\n  * **Nucleus:** Control center with DNA; regulates cell functions.\r\n\r\n---\r\n\r\n24. **Fluid Mosaic Model of Plasma Membrane**\r\n\r\n* Describes membrane as flexible, made of lipid bilayer with embedded proteins.\r\n* Lipids provide fluidity; proteins function as channels, receptors, and transporters.\r\n* Called “mosaic” because of patchwork of proteins in the fluid membrane.\r\n* Explains selective permeability and dynamic nature of the membrane.\r\n\r\n---\r\n\r\n25. **Plasmolysis with Diagram**\r\n\r\n* **\\[Include diagram showing plant cell in hypertonic solution with shrunken cytoplasm]**\r\n* Process in which water leaves cell due to osmosis in a hypertonic solution.\r\n* Cytoplasm shrinks away from cell wall.\r\n* Occurs in plant cells and is reversible in early stages.\r\n\r\n---\r\n\r\n26. **Structure and Function of Mitochondria**\r\n\r\n* Double membrane organelle: Outer membrane smooth, inner membrane folded into cristae.\r\n* Matrix contains enzymes and mitochondrial DNA.\r\n* Site of cellular respiration – converts glucose to ATP.\r\n* Called *“powerhouse of the cell”* as it provides energy needed for cellular activities.\r\n\r\n---\r\n\r\n### **Section E – Case Study Based Question (10 marks)**\r\n\r\n**27. Passage-Based Questions**\r\n\r\na) **Osmosis**\r\n→ The movement of water into the raisins caused them to swell.\r\n\r\nb) **Water Concentration During Swelling**\r\n→ Outside water concentration was higher than inside, so water entered the raisins through osmosis.\r\n\r\nc) **Reason for Shrinking in Sugar Solution**\r\n→ Water moved out of the raisins into the concentrated sugar solution (hypertonic environment), causing them to shrink.\r\n\r\nd) **Effect of Placing Raisins in Salt Solution**\r\n→ Same as sugar solution: water would leave the raisin cells, causing shrinkage due to osmosis.\r\n\r\ne) **Two Real-Life Osmosis Examples**\r\n\r\n1. Water absorption by root hairs in plants.\r\n2. Swelling of dry fruits when soaked in water.\r\n\r\n---\r\n\r\n\r\n	\N	2025-05-19 08:48:52.007818	1
43	Sample 	Sample	t	60	Sample	\N	2025-05-22 07:07:57.109498	4
49	Class 9 Mathematics Test ( 1 ) 	3 Chapters	t	118	\r\n📝 Class 9 Mathematics Test (MCQ Only)\r\n\r\nChapters Covered:\r\n • Chapter 1: Number Systems\r\n • Chapter 2: Polynomials\r\n • Chapter 3: Coordinate Geometry\r\n\r\nMaximum Marks: 70\r\nTime Allowed: 3 Hours\r\n\r\n\r\n⸻\r\n\r\n✅ Section A: Standard MCQs (1 × 20 = 20 Marks)\r\n\r\n(Each question carries 1 mark)\r\n 1. The decimal expansion of 7/8 is:\r\na) 0.875\r\nb) 0.877\r\nc) Non-terminating repeating\r\nd) Irrational\r\n 2. Which of the following is a rational number?\r\na) √2\r\nb) pi\r\nc) 3/4\r\nd) √3\r\n 3. The square of an irrational number is:\r\na) Always rational\r\nb) Always irrational\r\nc) Sometimes rational\r\nd) 0\r\n 4. The value of x for which x + 1/x = 2 is:\r\na) 2\r\nb) 1\r\nc) –1\r\nd) 0\r\n 5. The degree of the polynomial 5x^4 + 3x^2 - 7x + 6 is:\r\na) 3\r\nb) 2\r\nc) 4\r\nd) 1\r\n 6. The value of p(2) if p(x) = x^2 - 2x + 3 is:\r\na) 1\r\nb) 2\r\nc) 3\r\nd) 4\r\n 7. A linear polynomial in one variable is of the form:\r\na) ax^2 + b\r\nb) ax + b\r\nc) a\r\nd) ax^3 + bx\r\n 8. The number of terms in the polynomial x^3 + 2x^2 + 3x + 4 is:\r\na) 2\r\nb) 3\r\nc) 4\r\nd) 5\r\n 9. If x = -1 is a zero of x^2 + 2x + 1, then the polynomial is divisible by:\r\na) x + 1\r\nb) x - 1\r\nc) x + 2\r\nd) x - 2\r\n 10. The coordinates of a point on the y-axis are:\r\na) (0, y)\r\nb) (x, 0)\r\nc) (x, y)\r\nd) (0, 0)\r\n 11. The point (–3, 4) lies in:\r\na) Quadrant I\r\nb) Quadrant II\r\nc) Quadrant III\r\nd) Quadrant IV\r\n 12. The point (0, 0) is called:\r\na) X-axis\r\nb) Y-axis\r\nc) Origin\r\nd) Midpoint\r\n 13. The x-coordinate of any point on the y-axis is:\r\na) 1\r\nb) 0\r\nc) Cannot be determined\r\nd) y\r\n 14. The zero of the polynomial x + 5 is:\r\na) –5\r\nb) 5\r\nc) 0\r\nd) 1\r\n 15. The value of √49 is:\r\na) 6\r\nb) 7\r\nc) 8\r\nd) 9\r\n 16. Which of the following is not a polynomial?\r\na) x^2 + 1\r\nb) 1/x + x\r\nc) x^3 - x + 2\r\nd) 5x\r\n 17. The remainder when x^2 + 3x + 2 is divided by x + 1 is:\r\na) 1\r\nb) 2\r\nc) 0\r\nd) 3\r\n 18. A polynomial with only one term is called:\r\na) Monomial\r\nb) Binomial\r\nc) Trinomial\r\nd) Constant\r\n 19. Which of these cannot be the degree of a polynomial?\r\na) 0\r\nb) –1\r\nc) 2\r\nd) 3\r\n 20. Which point lies in the third quadrant?\r\na) (3, –2)\r\nb) (–3, –2)\r\nc) (–3, 2)\r\nd) (3, 2)\r\n\r\n⸻\r\n\r\n✅ Section B: Assertion and Reason (2 × 5 = 10 Marks)\r\n\r\n(Each question carries 2 marks)\r\nChoose the correct option:\r\na) Both A and R are true, and R is the correct explanation of A.\r\nb) Both A and R are true, but R is not the correct explanation of A.\r\nc) A is true, but R is false.\r\nd) A is false, but R is true.\r\n 21. \r\n\r\nAssertion (A): Every irrational number is a real number.\r\nReason (R): Real numbers consist of rational and irrational numbers.\r\n 22. \r\n\r\nAssertion (A): The graph of a linear polynomial is a straight line.\r\nReason (R): Linear polynomials have degree 2.\r\n 23. \r\n\r\nAssertion (A): All polynomials are algebraic expressions.\r\nReason (R): Algebraic expressions may not always be polynomials.\r\n 24. \r\n\r\nAssertion (A): √5 is a rational number.\r\nReason (R): Rational numbers are those that can be expressed in the form \\frac{p}{q}.\r\n 25. \r\n\r\nAssertion (A): The coordinates of the origin are (1, 1).\r\nReason (R): Origin is the point where x-axis and y-axis intersect.\r\n	\N	2025-05-25 12:43:08.671313	1
50	Class 9 Mathematics Test ( 2 )	3 Chapters	t	60	✅ Section C: Case Study Based MCQs (2 × 20 = 40 Marks)\r\n\r\n(Each case study contains 5 MCQs of 2 marks each = 10 marks per case)\r\n\r\n⸻\r\n\r\nCase Study 1: Square Root Spiral\r\n\r\nRavi constructs a square root spiral starting with a right triangle of legs 1 unit each. He continues drawing right triangles on the hypotenuse to build the spiral.\r\n\r\n26. The length of the first hypotenuse is:\r\na) √1\r\nb) √2\r\nc) √3\r\nd) √4\r\n\r\n27. The hypotenuse of the triangle built on the side √2 and 1 is:\r\na) √3\r\nb) √4\r\nc) √5\r\nd) √6\r\n\r\n28. The point on the number line representing \\sqrt{5} lies between:\r\na) 1 and 2\r\nb) 2 and 3\r\nc) 3 and 4\r\nd) 4 and 5\r\n\r\n29. √7 is \r\na) Rational\r\nb) Irrational\r\nc) Whole number\r\nd) Prime number\r\n\r\n30. The number represented geometrically by the 4th triangle in the spiral is:\r\na) √3\r\nb) √4\r\nc) √5\r\nd) √6\r\n\r\n⸻\r\n\r\nCase Study 2: School Playground Coordinate Geometry\r\n\r\nStudents plot points of a rectangular school playground:\r\nA(0, 0), B(0, 40), C(60, 40), D(60, 0)\r\n\r\n31. The shape formed by joining points A, B, C, D is:\r\na) Square\r\nb) Rectangle\r\nc) Triangle\r\nd) Trapezium\r\n\r\n32. The length of AB is:\r\na) 60 units\r\nb) 40 units\r\nc) 100 units\r\nd) 50 units\r\n\r\n33. Point C lies in which quadrant?\r\na) Quadrant I\r\nb) Quadrant II\r\nc) Quadrant III\r\nd) On the y-axis\r\n\r\n34. The coordinates of point D are:\r\na) (60, 40)\r\nb) (0, 0)\r\nc) (60, 0)\r\nd) (0, 60)\r\n\r\n35. What is the x-coordinate of point A?\r\na) 40\r\nb) 0\r\nc) 60\r\nd) 20	\N	2025-05-25 12:44:34.524237	1
52	Mathematics Class X Test ( 1 )	5 Chapters Covered	t	150	### **Mathematics Class X Test**\r\n\r\n**Chapters Covered**:\r\n\r\n1. Real Numbers\r\n2. Polynomials\r\n3. Pair of Linear Equations in Two Variables\r\n4. Quadratic Equations\r\n5. Arithmetic Progressions\r\n\r\n📝 **Question Types**: MCQs (including Assertion-Reason & Case Study)\r\n🕒 **Time**: 2 Hours\r\n🧮 **Maximum Marks**: 70\r\n\r\n---\r\n\r\n## **SECTION A: MCQs (1 mark each) \\[20 Marks]**\r\n\r\n**Q1.** The HCF of 65 and 117 is:\r\na) 1\r\nb) 13\r\nc) 5\r\nd) 3\r\n\r\n**Q2.** The decimal expansion of 7/250 will terminate after:\r\na) 1 decimal place\r\nb) 2 decimal places\r\nc) 3 decimal places\r\nd) 6 decimal places\r\n\r\n**Q3.** Which of the following is a factor of the polynomial x^3 - 3x^2 - x + 3?\r\na) x - 3\r\nb) x + 3\r\nc) x + 1\r\nd) x - 1\r\n\r\n**Q4.** If α and β are the zeroes of the polynomial ax^2 + bx + c, then α + β =:\r\na) b/a\r\nb) -b/a\r\nc) -c/a\r\nd)c/a\r\n\r\n**Q5.** The pair of equations x + y = 5 and 2x + 2y = 10 is:\r\na) Consistent and independent\r\nb) Inconsistent\r\nc) Consistent and dependent\r\nd) None of these\r\n\r\n**Q6.** The pair of equations 3x - 2y = 6 and 6x - 4y = 12 has:\r\na) No solution\r\nb) A unique solution\r\nc) Infinitely many solutions\r\nd) Only one solution\r\n\r\n**Q7.** The quadratic equation x^2 - 5x + 6 = 0 has:\r\na) Real and equal roots\r\nb) Imaginary roots\r\nc) Real and unequal roots\r\nd) No roots\r\n\r\n**Q8.** The roots of the equation x^2 - 4x + 4 = 0 are:\r\na) 2, -2\r\nb) 0, 4\r\nc) 2, 2\r\nd) 4, 0\r\n\r\n**Q9.** If the 7th term of an AP is 29 and the 16th term is 65, then the common difference is:\r\na) 3\r\nb) 4\r\nc) 5\r\nd) 6\r\n\r\n**Q10.** The sum of first 20 terms of the AP: 2, 7, 12, 17... is:\r\na) 580\r\nb) 600\r\nc) 620\r\nd) 640\r\n\r\n**Q11.** If one root of the quadratic equation 2x^2 + 5x + k = 0 is double the other, then k is:\r\na) 10\r\nb) 9\r\nc) 8\r\nd) 7\r\n\r\n**Q12.** The equation 2x + 3y = 12 and 3x + 2y = 12 is solved by which method best?\r\na) Substitution\r\nb) Cross Multiplication\r\nc) Graphical\r\nd) Elimination\r\n\r\n**Q13.** If the sum and product of the zeroes of the polynomial x^2 - 6x + p are 6 and p respectively, the value of p is:\r\na) 8\r\nb) 9\r\nc) 10\r\nd) 12\r\n\r\n**Q14.** The nth term of the AP whose first term is 5 and common difference is 3 is:\r\na) 5n + 3\r\nb) 3n + 2\r\nc) 5 + 3n\r\nd) 5 + (n – 1) × 3\r\n\r\n**Q15.** The least number that is divisible by 6, 15 and 20 is:\r\na) 30\r\nb) 60\r\nc) 120\r\nd) 90\r\n\r\n**Q16.** If a rational number is terminating, its denominator has prime factors:\r\na) 2 or 3\r\nb) Only 3\r\nc) Only 2 and 5\r\nd) Only 7\r\n\r\n**Q17.** The solution of the equation 3x - 4 = 2x + 1 is:\r\na) 0\r\nb) 1\r\nc) 2\r\nd) 5\r\n\r\n**Q18.** The common difference of the AP 7, 10, 13, 16, ... is:\r\na) 2\r\nb) 3\r\nc) 4\r\nd) 5\r\n\r\n**Q19.** If x^2 + 4x + 3 = 0, then roots are:\r\na) -1, -3\r\nb) 1, 3\r\nc) -1, 3\r\nd) 1, -3\r\n\r\n**Q20.** The value of k for which x^2 + kx + 16 has equal roots is:\r\na) 8\r\nb) -8\r\nc) ±8\r\nd) 4\r\n\r\n---\r\n\r\n## **SECTION B: Assertion-Reason Based (2 marks each) \\[10 Marks]**\r\n\r\nIn each question, choose the correct option:\r\n\r\n* a) Both A and R are true and R is the correct explanation of A\r\n* b) Both A and R are true but R is not the correct explanation of A\r\n* c) A is true but R is false\r\n* d) A is false but R is true\r\n\r\n**Q21.**\r\n**Assertion (A):** Every rational number is a real number.\r\n**Reason (R):** Real numbers include both rational and irrational numbers.\r\n\r\n**Q22.**\r\n**Assertion (A):** The pair of equations x + y = 2 and 2x + 2y = 5 is inconsistent.\r\n**Reason (R):** The lines representing the equations are parallel.\r\n\r\n**Q23.**\r\n**Assertion (A):** The zeroes of a quadratic polynomial are equal if its discriminant is zero.\r\n**Reason (R):** The discriminant D = b^2 - 4ac.\r\n\r\n**Q24.**\r\n**Assertion (A):** The nth term of an AP is given by a + (n – 1)d.\r\n**Reason (R):** The sum of n terms is n/2(a+l)\r\n\r\n**Q25.**\r\n**Assertion (A):** √2 is a rational number.\r\n**Reason (R):** A number is rational if it can be expressed in the form p/q, where p and q are integers and q ≠ 0.	\N	2025-05-25 12:59:40.537837	1
53	Mathematics Class X Test ( 2 ) 	5 Chapters	t	120	## **SECTION C: Case Study Based MCQs (4 Cases × 5 marks each = 20 marks)**\r\n\r\nEach case contains a passage followed by 5 MCQs (1 mark each). Attempt all questions.\r\n\r\n---\r\n\r\n### **CASE STUDY 1: Real Numbers in Daily Life**\r\n\r\nRahul is calculating the number of complete cycles a pair of traffic lights can flash together. One light flashes every 45 seconds, and the other every 60 seconds.\r\n\r\n**Q26.** What is the time interval at which both lights will flash together again?\r\na) 5 minutes\r\nb) 3 minutes\r\nc) 2 minutes\r\nd) 4 minutes\r\n\r\n**Q27.** What mathematical concept is used here?\r\na) HCF\r\nb) LCM\r\nc) Factorization\r\nd) Euclid’s Division Lemma\r\n\r\n**Q28.** LCM of 45 and 60 is:\r\na) 180\r\nb) 90\r\nc) 120\r\nd) 150\r\n\r\n**Q29.** The HCF of 45 and 60 is:\r\na) 15\r\nb) 30\r\nc) 10\r\nd) 5\r\n\r\n**Q30.** Which of these numbers has a terminating decimal?\r\na) 1/3\r\nb) 1/5\r\nc) 1/7\r\nd) 1/9\r\n\r\n---\r\n\r\n### **CASE STUDY 2: Solving Linear Equations**\r\n\r\nAmit is trying to find the solution to the system:\r\n\r\n\r\nx + y = 10 \r\n2x + 3y = 26\r\n\r\n\r\n**Q31.** Which method best solves this system?\r\na) Substitution\r\nb) Graphical\r\nc) Elimination\r\nd) Trial and error\r\n\r\n**Q32.** Multiply the first equation by 2. What does it become?\r\na) 2x + 3y = 20\r\nb) 2x + 2y = 20\r\nc) 3x + 2y = 20\r\nd) x + y = 20\r\n\r\n**Q33.** After substitution, the value of x is:\r\na) 2\r\nb) 4\r\nc) 6\r\nd) 8\r\n\r\n**Q34.** The solution of the system is:\r\na) x = 4, y = 6\r\nb) x = 6, y = 4\r\nc) x = 2, y = 8\r\nd) x = 5, y = 5\r\n\r\n**Q35.** This system is:\r\na) Consistent with unique solution\r\nb) Inconsistent\r\nc) Dependent\r\nd) Has infinite solutions\r\n\r\n---\r\n\r\n### **CASE STUDY 3: Quadratic Application**\r\n\r\nA ball is thrown upwards. Its height (in meters) at time t seconds is given by:\r\n\r\n\r\nh(t) = -5t^2 + 20t + 1\r\n\r\n**Q36.** What is the maximum height?\r\na) 25 m\r\nb) 21 m\r\nc) 20 m\r\nd) 16 m\r\n\r\n**Q37.** What kind of curve does this equation represent?\r\na) Straight Line\r\nb) Circle\r\nc) Parabola\r\nd) Ellipse\r\n\r\n**Q38.** At t = 1, what is the height?\r\na) 16\r\nb) 20\r\nc) 25\r\nd) 21\r\n\r\n**Q39.** After how many seconds will the ball hit the ground?\r\na) 1 sec\r\nb) 2 sec\r\nc) 5 sec\r\nd) 6 sec\r\n\r\n**Q40.** The discriminant of this equation is:\r\na) 400\r\nb) 375\r\nc) 225\r\nd) 625\r\n\r\n---\r\n\r\n### **CASE STUDY 4: Arithmetic Progression in Life**\r\n\r\nNeha saves ₹200 in the first month, ₹250 in the second month, ₹300 in the third, and so on.\r\n\r\n**Q41.** What type of sequence is this?\r\na) Geometric Progression\r\nb) Arithmetic Progression\r\nc) Harmonic\r\nd) Linear\r\n\r\n**Q42.** What is the common difference?\r\na) ₹50\r\nb) ₹100\r\nc) ₹25\r\nd) ₹75\r\n\r\n**Q43.** How much will she save in the 6th month?\r\na) ₹500\r\nb) ₹450\r\nc) ₹550\r\nd) ₹600\r\n\r\n**Q44.** Total savings in 6 months:\r\na) ₹2100\r\nb) ₹1800\r\nc) ₹1900\r\nd) ₹1500\r\n\r\n**Q45.** Which formula is used to calculate the nth term of AP?\r\na) a(n) = a + nd\r\nb) a(n) = a + (n - 1)d\r\nc) a(n) = a - (n - 1)d\r\nd) a(n) = d - (n - 1)a\r\n	\N	2025-05-25 13:00:59.538417	1
\.


--
-- Data for Name: test_assignment; Type: TABLE DATA; Schema: public; Owner: tuition_db_5_user
--

COPY public.test_assignment (id, test_id, student_id, status, date_assigned, start_time, end_time, score, due_date) FROM stdin;
12	9	23	Pending	2025-05-10 06:19:39.442362	\N	\N	\N	\N
11	9	21	Completed	2025-05-10 06:19:39.442311	2025-05-10 06:31:21.913129	2025-05-10 07:18:03.572681	27	\N
13	10	18	Completed	2025-05-10 06:33:58.144265	2025-05-10 06:35:38.556398	2025-05-10 07:16:11.330536	22.5	\N
14	10	24	Completed	2025-05-10 06:33:58.144426	2025-05-10 06:35:02.876446	2025-05-10 07:32:24.704053	22	\N
15	10	26	Completed	2025-05-10 06:33:58.14448	2025-05-10 06:34:29.840673	2025-05-10 07:24:00.792348	12	\N
16	10	27	Completed	2025-05-10 06:33:58.144532	2025-05-10 06:35:47.887886	2025-05-10 07:35:47.887886	22	\N
24	12	27	In Progress	2025-05-10 08:05:38.142843	2025-05-10 08:24:07.05659	\N	\N	\N
10	9	17	In Progress	2025-05-10 06:19:39.442126	2025-05-13 09:53:30.604038	\N	\N	\N
23	12	26	In Progress	2025-05-10 08:05:38.142819	2025-05-15 05:05:57.957933	\N	\N	\N
22	12	24	In Progress	2025-05-10 08:05:38.142784	2025-05-18 08:19:56.761631	\N	\N	\N
55	30	29	In Progress	2025-05-18 16:57:43.860309	2025-05-18 16:58:20.571236	\N	\N	\N
56	31	27	Pending	2025-05-19 08:48:52.152721	\N	\N	\N	\N
58	31	24	Pending	2025-05-19 08:48:52.152944	\N	\N	\N	\N
21	12	18	In Progress	2025-05-10 08:05:38.142665	2025-05-18 05:56:12.272641	\N	\N	\N
48	24	27	Completed	2025-05-18 07:09:55.15582	2025-05-18 07:10:11.935562	2025-05-18 08:14:52.657052	14	\N
46	24	24	Completed	2025-05-18 07:09:55.155716	2025-05-18 07:10:26.686258	2025-05-18 08:17:53.290346	62	\N
45	24	18	Completed	2025-05-18 07:09:55.155506	2025-05-18 07:15:45.161363	2025-05-18 08:33:23.514127	55	\N
47	24	26	Completed	2025-05-18 07:09:55.155777	2025-05-18 07:23:09.621031	2025-05-18 07:32:41.423977	13	\N
75	43	28	Completed	2025-05-22 07:07:57.361896	2025-05-22 07:08:25.105595	2025-05-22 07:09:17.799287	\N	\N
57	31	26	In Progress	2025-05-19 08:48:52.152877	2025-05-24 04:46:27.469834	\N	\N	\N
86	49	27	Pending	2025-05-25 12:43:08.831646	\N	\N	\N	\N
87	49	26	Pending	2025-05-25 12:43:08.831695	\N	\N	\N	\N
91	50	27	Pending	2025-05-25 12:44:34.686859	\N	\N	\N	\N
49	24	29	Completed	2025-05-18 07:09:55.155853	2025-05-18 07:11:11.021508	2025-05-18 07:55:08.287154	\N	\N
92	50	26	Pending	2025-05-25 12:44:34.686918	\N	\N	\N	\N
85	49	29	In Progress	2025-05-25 12:43:08.831498	2025-05-25 12:44:58.791521	\N	\N	\N
96	52	12	Pending	2025-05-25 12:59:40.693392	\N	\N	\N	\N
99	52	23	Pending	2025-05-25 12:59:40.693615	\N	\N	\N	\N
100	52	17	Pending	2025-05-25 12:59:40.69365	\N	\N	\N	\N
101	53	12	Pending	2025-05-25 13:00:59.701639	\N	\N	\N	\N
103	53	21	Pending	2025-05-25 13:00:59.701771	\N	\N	\N	\N
104	53	23	Pending	2025-05-25 13:00:59.701795	\N	\N	\N	\N
105	53	17	Pending	2025-05-25 13:00:59.701817	\N	\N	\N	\N
97	52	29	Completed	2025-05-25 12:59:40.693524	2025-05-25 13:03:36.32615	2025-05-25 15:33:36.32615	\N	\N
89	49	18	Completed	2025-05-25 12:43:08.83177	2025-05-25 15:04:48.653572	2025-05-25 15:46:58.998168	\N	\N
59	31	18	In Progress	2025-05-19 08:48:52.152986	2025-05-25 15:47:15.519945	\N	\N	\N
102	53	29	Completed	2025-05-25 13:00:59.70174	2025-05-25 21:16:08.922601	2025-05-25 21:17:22.244676	\N	\N
88	49	24	Completed	2025-05-25 12:43:08.831734	2025-05-25 15:26:48.168614	2025-05-25 16:47:43.447086	\N	\N
98	52	21	In Progress	2025-05-25 12:59:40.693578	2025-05-25 16:52:14.191048	\N	\N	\N
90	50	29	Completed	2025-05-25 12:44:34.686697	2025-05-26 03:35:02.150273	2025-05-26 03:35:43.694991	1	\N
94	50	18	Completed	2025-05-25 12:44:34.686985	2025-05-25 15:04:29.595435	2025-05-25 16:04:29.595435	30	\N
93	50	24	Completed	2025-05-25 12:44:34.686955	2025-05-25 16:20:01.953689	2025-05-25 16:47:03.452037	32	\N
\.


--
-- Data for Name: test_response; Type: TABLE DATA; Schema: public; Owner: tuition_db_5_user
--

COPY public.test_response (id, assignment_id, content, file_path, "timestamp") FROM stdin;
8	11		\N	2025-05-10 06:31:53.305646
9	11		\N	2025-05-10 06:32:24.862495
10	11		\N	2025-05-10 06:32:53.305481
11	11		\N	2025-05-10 06:33:23.538911
12	11		\N	2025-05-10 06:33:53.900265
13	11		\N	2025-05-10 06:34:23.315922
14	11		\N	2025-05-10 06:34:53.308177
15	15		\N	2025-05-10 06:35:01.088768
16	11		\N	2025-05-10 06:35:25.970635
17	15		\N	2025-05-10 06:35:31.383101
18	14		\N	2025-05-10 06:35:34.042142
19	11		\N	2025-05-10 06:35:53.320334
20	15		\N	2025-05-10 06:36:01.045094
21	14		\N	2025-05-10 06:36:04.613988
22	13		\N	2025-05-10 06:36:10.069581
23	16		\N	2025-05-10 06:36:21.979648
24	11		\N	2025-05-10 06:36:23.312221
25	15		\N	2025-05-10 06:36:31.146884
26	13	 1.  Speed\r\n	\N	2025-05-10 06:36:40.806266
27	16	1	\N	2025-05-10 06:36:52.424114
28	11		\N	2025-05-10 06:36:53.323038
29	15		\N	2025-05-10 06:37:01.640944
30	14		\N	2025-05-10 06:37:04.00809
31	13	 1.  Speed\r\n2. m/s\r\n	\N	2025-05-10 06:37:09.931273
32	11		\N	2025-05-10 06:37:23.316949
33	15		\N	2025-05-10 06:37:31.052479
34	14		\N	2025-05-10 06:37:34.238849
35	13	 1.  Speed\r\n2. m/s\r\n3. Cover e	\N	2025-05-10 06:37:40.753025
36	11		\N	2025-05-10 06:37:53.917854
37	15		\N	2025-05-10 06:38:01.076079
38	14		\N	2025-05-10 06:38:04.188454
39	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal in	\N	2025-05-10 06:38:09.94779
40	11		\N	2025-05-10 06:38:23.52372
41	15		\N	2025-05-10 06:38:30.930105
42	14		\N	2025-05-10 06:38:33.98318
43	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n	\N	2025-05-10 06:38:40.088491
44	11		\N	2025-05-10 06:38:53.426845
45	16	1	\N	2025-05-10 06:38:58.322956
46	15	1)speed\r\n2	\N	2025-05-10 06:39:00.923893
47	14		\N	2025-05-10 06:39:04.179953
48	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object	\N	2025-05-10 06:39:10.473034
49	11		\N	2025-05-10 06:39:23.301717
50	16	1	\N	2025-05-10 06:39:28.326723
51	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 06:39:31.117583
52	14		\N	2025-05-10 06:39:33.942784
53	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its in	\N	2025-05-10 06:39:40.268736
54	11		\N	2025-05-10 06:39:53.308222
55	16	1D) Speed	\N	2025-05-10 06:39:58.322491
56	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 06:40:01.05824
57	14		\N	2025-05-10 06:40:04.202488
58	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n	\N	2025-05-10 06:40:10.20163
59	11		\N	2025-05-10 06:40:23.702243
60	16	1D\r\n) Speed	\N	2025-05-10 06:40:28.371929
61	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 06:40:31.467982
62	14		\N	2025-05-10 06:40:33.989861
63	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5.	\N	2025-05-10 06:40:40.082137
64	11		\N	2025-05-10 06:40:53.423482
65	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 06:41:00.912484
66	14		\N	2025-05-10 06:41:03.966169
67	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n	\N	2025-05-10 06:41:10.59777
68	16	1D\r\n) Speed	\N	2025-05-10 06:41:18.82082
69	11		\N	2025-05-10 06:41:23.426831
70	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 06:41:30.935587
71	14		\N	2025-05-10 06:41:34.056929
72	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n	\N	2025-05-10 06:41:40.074383
73	16	1d)\r\n2\r\n3	\N	2025-05-10 06:41:49.127051
74	11		\N	2025-05-10 06:41:53.45833
75	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 06:42:00.961568
76	14		\N	2025-05-10 06:42:03.975751
77	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n	\N	2025-05-10 06:42:11.656362
78	16	1d)\r\n2\r\n3c\r\n4	\N	2025-05-10 06:42:20.294612
79	11		\N	2025-05-10 06:42:23.650852
80	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 06:42:30.919795
81	14		\N	2025-05-10 06:42:34.004359
82	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n	\N	2025-05-10 06:42:40.563813
83	16	1d)\r\n2\r\n3c\r\n4b	\N	2025-05-10 06:42:50.575362
84	11		\N	2025-05-10 06:42:54.051352
85	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 06:43:00.897505
86	14		\N	2025-05-10 06:43:04.281587
87	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n	\N	2025-05-10 06:43:11.202343
88	16	1d)\r\n2\r\n3c\r\n4b\r\n5b	\N	2025-05-10 06:43:20.310401
89	11		\N	2025-05-10 06:43:23.680449
90	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 06:43:30.909755
91	14		\N	2025-05-10 06:43:34.033699
92	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4	\N	2025-05-10 06:43:40.537118
93	16	1d)\r\n2\r\n3c\r\n4b\r\n5b\r\n6b	\N	2025-05-10 06:43:50.782906
94	11		\N	2025-05-10 06:43:53.34469
95	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 06:44:01.473777
96	14		\N	2025-05-10 06:44:04.208357
97	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n\r\n	\N	2025-05-10 06:44:09.98158
98	16	1d)\r\n2\r\n3c\r\n4b\r\n5b\r\n6b	\N	2025-05-10 06:44:20.881464
99	11		\N	2025-05-10 06:44:24.080426
100	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 06:44:30.908588
101	14		\N	2025-05-10 06:44:34.0199
102	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n\r\n	\N	2025-05-10 06:44:41.56969
103	16	1d)\r\n2\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a	\N	2025-05-10 06:44:50.522402
104	11		\N	2025-05-10 06:44:53.456247
105	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 06:45:01.095734
106	14		\N	2025-05-10 06:45:04.24872
107	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n\r\n	\N	2025-05-10 06:45:10.000065
108	16	1d)\r\n2\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a	\N	2025-05-10 06:45:20.28093
109	11		\N	2025-05-10 06:45:23.423011
110	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 06:45:31.047441
111	14		\N	2025-05-10 06:45:33.978946
112	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n\r\n	\N	2025-05-10 06:45:40.781059
113	16	1d)\r\n2\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a	\N	2025-05-10 06:45:52.729592
114	11		\N	2025-05-10 06:45:53.444845
115	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 06:46:01.51236
116	14		\N	2025-05-10 06:46:04.192594
117	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n\r\n	\N	2025-05-10 06:46:11.054136
118	16	1d)\r\n2\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a	\N	2025-05-10 06:46:20.749615
119	11		\N	2025-05-10 06:46:23.455537
120	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 06:46:31.231297
121	14		\N	2025-05-10 06:46:34.060741
122	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n\r\n	\N	2025-05-10 06:46:41.030798
123	16	1d)\r\n2\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a	\N	2025-05-10 06:46:51.258958
124	11		\N	2025-05-10 06:46:53.447385
125	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 06:47:00.892624
126	16	1d)\r\n2\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a	\N	2025-05-10 06:47:02.616299
127	14		\N	2025-05-10 06:47:04.193995
128	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n\r\n	\N	2025-05-10 06:47:11.118345
129	16	1d)\r\n2\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a	\N	2025-05-10 06:47:20.773983
130	11		\N	2025-05-10 06:47:23.454991
131	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 06:47:30.952594
132	16	1d)\r\n2\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8\r\n9a	\N	2025-05-10 06:47:32.9047
133	14		\N	2025-05-10 06:47:34.049222
134	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acce\r\n	\N	2025-05-10 06:47:39.96296
135	11		\N	2025-05-10 06:47:53.309828
136	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 06:48:01.054841
137	16	1d)\r\n2\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8\r\n9a	\N	2025-05-10 06:48:02.608352
138	14		\N	2025-05-10 06:48:04.25177
139	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n\r\n	\N	2025-05-10 06:48:10.013482
140	11		\N	2025-05-10 06:48:23.432979
141	16	1d)\r\n2\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a	\N	2025-05-10 06:48:24.74746
142	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 06:48:31.0421
143	16	1d)\r\n2\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8\r\n9a\r\n10\r\n11b	\N	2025-05-10 06:48:32.6204
144	14		\N	2025-05-10 06:48:34.107264
145	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is \r\n	\N	2025-05-10 06:48:40.191488
146	11		\N	2025-05-10 06:48:53.476007
147	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 06:49:01.025575
148	16	1d)\r\n2\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8\r\n9a\r\n10\r\n11b	\N	2025-05-10 06:49:02.752034
149	14		\N	2025-05-10 06:49:03.959458
150	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n\r\n	\N	2025-05-10 06:49:10.048714
151	11		\N	2025-05-10 06:49:23.637223
152	16	1d)\r\n2\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a	\N	2025-05-10 06:49:25.505364
153	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 06:49:31.344116
154	16	1d)\r\n2\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8\r\n9a\r\n10\r\n11b	\N	2025-05-10 06:49:33.083765
155	14		\N	2025-05-10 06:49:33.996231
156	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n\r\n	\N	2025-05-10 06:49:41.682831
157	11		\N	2025-05-10 06:49:54.070049
158	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 06:50:01.069381
159	16	1d)\r\n2\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8\r\n9a\r\n10\r\n11b	\N	2025-05-10 06:50:03.362053
160	14		\N	2025-05-10 06:50:03.987593
161	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n\r\n	\N	2025-05-10 06:50:11.031817
162	11		\N	2025-05-10 06:50:23.750695
163	16	1d)\r\n2\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a	\N	2025-05-10 06:50:24.883058
164	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 06:50:30.922645
165	16	1d)\r\n2\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8\r\n9a\r\n10\r\n11b	\N	2025-05-10 06:50:33.012189
166	14		\N	2025-05-10 06:50:33.992314
167	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n\r\n	\N	2025-05-10 06:50:41.748974
168	11		\N	2025-05-10 06:50:53.438443
169	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 06:51:00.938587
170	16	1d)\r\n2\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8\r\n9a\r\n10\r\n11b	\N	2025-05-10 06:51:02.581713
171	14		\N	2025-05-10 06:51:04.200387
172	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n\r\n	\N	2025-05-10 06:51:10.980042
173	11		\N	2025-05-10 06:51:23.679437
174	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 06:51:31.812315
175	16	1d)\r\n2\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8\r\n9a\r\n10\r\n11b\r\n12\r\n13d	\N	2025-05-10 06:51:32.655805
176	14	1 	\N	2025-05-10 06:51:34.238686
177	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n\r\n	\N	2025-05-10 06:51:40.176623
178	11		\N	2025-05-10 06:51:53.31702
179	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 06:52:01.100675
180	16	1d)\r\n2\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8\r\n9a\r\n10\r\n11b\r\n12\r\n13d	\N	2025-05-10 06:52:02.601579
181	14	1 d ) speed\r\n2 b) m/s \r\n3 	\N	2025-05-10 06:52:04.211902
182	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n\r\n	\N	2025-05-10 06:52:10.075879
183	11		\N	2025-05-10 06:52:24.728148
184	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 06:52:30.963136
185	16	1d)\r\n2\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8\r\n9a\r\n10\r\n11b\r\n12\r\n13d\r\n14a	\N	2025-05-10 06:52:32.624406
186	14	1 d ) speed\r\n2 b) m/s \r\n3 	\N	2025-05-10 06:52:34.060848
187	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n\r\n	\N	2025-05-10 06:52:40.050863
188	11		\N	2025-05-10 06:52:53.307995
189	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 06:53:00.930811
190	16	1d)\r\n2\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8\r\n9a\r\n10\r\n11b\r\n12\r\n13d\r\n14a\r\n15c	\N	2025-05-10 06:53:02.646968
191	14	1 d ) speed\r\n2 b) m/s \r\n3 c) 	\N	2025-05-10 06:53:04.065189
254	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B 	\N	2025-05-10 06:59:34.086385
192	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n\r\n	\N	2025-05-10 06:53:11.575714
193	11		\N	2025-05-10 06:53:23.449988
194	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 06:53:31.171472
195	16	1d)\r\n2\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8\r\n9a\r\n10\r\n11b\r\n12\r\n13d\r\n14a\r\n15c	\N	2025-05-10 06:53:33.040496
196	14	1 d ) speed\r\n2 b) m/s \r\n3 c) 	\N	2025-05-10 06:53:34.130755
197	11		\N	2025-05-10 06:53:53.424322
198	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n\r\n	\N	2025-05-10 06:53:55.81845
199	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 06:54:01.091414
200	14	1 d ) speed\r\n2 b) m/s \r\n3 c) 	\N	2025-05-10 06:54:04.222335
201	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n\r\n	\N	2025-05-10 06:54:10.492737
202	16	1d)\r\n2\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8\r\n9a\r\n10\r\n11b\r\n12\r\n13d\r\n14a\r\n15c	\N	2025-05-10 06:54:10.947469
203	11		\N	2025-05-10 06:54:23.425788
204	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 06:54:30.955578
205	14	1 d ) speed\r\n2 b) m/s \r\n3 c) 	\N	2025-05-10 06:54:34.019219
206	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n12. 3.\r\n	\N	2025-05-10 06:54:40.056149
207	16	1d)\r\n2\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8\r\n9a\r\n10\r\n11b\r\n12\r\n13d\r\n14a\r\n15c	\N	2025-05-10 06:54:41.297933
208	11		\N	2025-05-10 06:54:53.448185
209	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 06:55:00.994914
210	14	1 d ) speed\r\n2 b) m/s \r\n3 c) 	\N	2025-05-10 06:55:04.23652
211	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n12. 3.6 m/s²\r\n13.\r\n	\N	2025-05-10 06:55:09.989324
212	16	1d)\r\n2\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8\r\n9a\r\n10\r\n11b\r\n12\r\n13d\r\n14a\r\n15c	\N	2025-05-10 06:55:11.709348
213	11		\N	2025-05-10 06:55:23.639748
214	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 06:55:30.931738
215	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equa	\N	2025-05-10 06:55:34.016276
216	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n12. 3.6 m/s²\r\n13.s=vt\r\n	\N	2025-05-10 06:55:40.8126
217	16	1d)\r\n2\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8\r\n9a\r\n10\r\n11b\r\n12\r\n13d\r\n14a\r\n15c	\N	2025-05-10 06:55:41.057805
218	11		\N	2025-05-10 06:55:53.364071
219	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 06:56:00.979164
220	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B 	\N	2025-05-10 06:56:04.006082
221	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n12. 3.6 m/s²\r\n13.s=vt+½at²\r\n	\N	2025-05-10 06:56:10.017815
222	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8\r\n9a\r\n10\r\n11b\r\n12\r\n13d\r\n14a\r\n15c	\N	2025-05-10 06:56:11.001634
223	11		\N	2025-05-10 06:56:23.327068
224	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 06:56:31.065895
225	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B 	\N	2025-05-10 06:56:34.16119
226	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n12. 3.6 m/s²\r\n13.s=vt+½at²\r\n\r\n	\N	2025-05-10 06:56:40.161143
227	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8\r\n9a\r\n10\r\n11b\r\n12\r\n13d\r\n14a\r\n15c	\N	2025-05-10 06:56:41.203094
228	11		\N	2025-05-10 06:56:53.453768
229	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B 	\N	2025-05-10 06:57:04.258456
230	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n12. 3.6 m/s²\r\n13.s=vt+½at²\r\n14. 50 km/h\r\n	\N	2025-05-10 06:57:10.054481
231	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8\r\n9a\r\n10\r\n11b\r\n12\r\n13d\r\n14a\r\n15c	\N	2025-05-10 06:57:11.109062
232	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 06:57:18.92227
233	11		\N	2025-05-10 06:57:23.446056
234	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B 	\N	2025-05-10 06:57:34.053855
235	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n12. 3.6 m/s²\r\n13.s=vt+½at²\r\n14. 50 km/h\r\n\r\n	\N	2025-05-10 06:57:40.331232
236	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8\r\n9a\r\n10\r\n11b\r\n12\r\n13d\r\n14a\r\n15c	\N	2025-05-10 06:57:40.996428
237	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 06:57:49.036658
238	11		\N	2025-05-10 06:57:53.307594
239	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B 	\N	2025-05-10 06:58:04.076731
240	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n12. 3.6 m/s²\r\n13.s=vt+½at²\r\n14. 50 km/h\r\n15. Change it\r\n	\N	2025-05-10 06:58:10.641255
241	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8\r\n9a\r\n10\r\n11b\r\n12\r\n13d\r\n14a\r\n15c	\N	2025-05-10 06:58:10.953919
242	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 06:58:19.124404
243	11		\N	2025-05-10 06:58:23.679438
244	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B 	\N	2025-05-10 06:58:34.070374
245	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n12. 3.6 m/s²\r\n13.s=vt+½at²\r\n14. 50 km/h\r\n15. Change its speed or direction or both\r\n\r\n	\N	2025-05-10 06:58:40.263336
246	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8\r\n9a\r\n10\r\n11b\r\n12\r\n13d\r\n14a\r\n15c	\N	2025-05-10 06:58:41.01966
247	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 06:58:49.047895
248	11		\N	2025-05-10 06:58:53.323025
249	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B 	\N	2025-05-10 06:59:04.250969
250	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n12. 3.6 m/s²\r\n13.s=vt+½at²\r\n14. 50 km/h\r\n15. Change its speed or direction or both\r\n\r\n	\N	2025-05-10 06:59:10.171445
251	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8\r\n9a\r\n10\r\n11b\r\n12\r\n13d\r\n14a\r\n15c	\N	2025-05-10 06:59:11.541406
252	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 06:59:22.007881
253	11		\N	2025-05-10 06:59:24.074724
499	10		\N	2025-05-13 09:54:02.215815
255	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n12. 3.6 m/s²\r\n13.s=vt+½at²\r\n14. 50 km/h\r\n15. Change its speed or direction or both\r\n20. 20m\r\n	\N	2025-05-10 06:59:40.070181
256	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8\r\n9a\r\n10\r\n11b\r\n12\r\n13d\r\n14a\r\n15c	\N	2025-05-10 06:59:41.0135
257	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 06:59:49.08807
258	11		\N	2025-05-10 06:59:53.311145
259	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B 	\N	2025-05-10 07:00:04.61339
260	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n12. 3.6 m/s²\r\n13.s=vt+½at²\r\n14. 50 km/h\r\n15. Change its speed or direction or both\r\n20. 20 m/s²\r\n\r\n	\N	2025-05-10 07:00:10.135158
261	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8\r\n9a\r\n10\r\n11b\r\n12\r\n13d\r\n14a\r\n15c	\N	2025-05-10 07:00:10.975897
262	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 07:00:19.067084
263	11		\N	2025-05-10 07:00:23.51061
264	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 07:00:24.300377
265	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B 	\N	2025-05-10 07:00:34.290387
266	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n12. 3.6 m/s²\r\n13.s=vt+½at²\r\n14. 50 km/h\r\n15. Change its speed or direction or both\r\n20. 20 m/s²\r\n\r\n	\N	2025-05-10 07:00:40.092648
267	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8\r\n9a\r\n10\r\n11b\r\n12\r\n13d\r\n14a\r\n15c	\N	2025-05-10 07:00:40.940783
268	11		\N	2025-05-10 07:00:53.429595
269	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 07:00:54.057639
270	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B 	\N	2025-05-10 07:01:04.099538
271	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n12. 3.6 m/s²\r\n13.s=vt+½at²\r\n14. 50 km/h\r\n15. Change its speed or direction or both\r\n20. 20 m/s²\r\n\r\n	\N	2025-05-10 07:01:10.041832
272	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 07:01:17.253808
273	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 07:01:18.155135
274	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8\r\n9a\r\n10\r\n11b\r\n12\r\n13d\r\n14a\r\n15c	\N	2025-05-10 07:01:21.094971
275	11		\N	2025-05-10 07:01:23.465923
276	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 07:01:27.177675
277	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B 	\N	2025-05-10 07:01:34.06225
278	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n12. 3.6 m/s²\r\n13.s=vt+½at²\r\n14. 50 km/h\r\n15. Change its speed or direction or both\r\n20. 20 m/s²\r\n\r\n	\N	2025-05-10 07:01:40.119933
279	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 07:01:47.29371
280	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8\r\n9a\r\n10\r\n11b\r\n12\r\n13d\r\n14a\r\n15c	\N	2025-05-10 07:01:51.594685
281	11		\N	2025-05-10 07:01:53.309734
282	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 07:01:57.227589
283	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B 	\N	2025-05-10 07:02:04.027721
284	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n12. 3.6 m/s²\r\n13.s=vt+½at²\r\n14. 50 km/h\r\n15. Change its speed or direction or both\r\n20. 20 m/s²\r\n19.  -2.5 m/s²\r\n\r\n	\N	2025-05-10 07:02:10.050821
285	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 07:02:17.32231
286	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 07:02:18.264124
287	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8\r\n9a\r\n10\r\n11b\r\n12\r\n13d\r\n14a\r\n15c	\N	2025-05-10 07:02:21.741307
288	11		\N	2025-05-10 07:02:24.372546
289	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B 	\N	2025-05-10 07:02:34.396003
290	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n12. 3.6 m/s²\r\n13.s=vt+½at²\r\n14. 50 km/h\r\n15. Change its speed or direction or both\r\n20. 20 m/s²\r\n19.  -2.5 m/s²\r\n\r\n	\N	2025-05-10 07:02:40.643481
291	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 07:02:47.328929
292	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8\r\n9a\r\n10\r\n11b\r\n12\r\n13d\r\n14a\r\n15c	\N	2025-05-10 07:02:52.197369
293	11		\N	2025-05-10 07:02:53.324333
294	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B 	\N	2025-05-10 07:03:04.01717
295	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n12. 3.6 m/s²\r\n13.s=vt+½at²\r\n14. 50 km/h\r\n15. Change its speed or direction or both\r\n20. 20 m/s²\r\n19.  -2.5 m/s²\r\n\r\n	\N	2025-05-10 07:03:10.032998
296	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 07:03:18.272602
297	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 07:03:18.70538
298	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 07:03:18.918191
299	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8\r\n9a\r\n10\r\n11b\r\n12\r\n13d\r\n14a\r\n15c	\N	2025-05-10 07:03:21.809683
300	11		\N	2025-05-10 07:03:23.652714
301	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B 	\N	2025-05-10 07:03:34.020879
302	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n12. 3.6 m/s²\r\n13.s=vt+½at²\r\n14. 50 km/h\r\n15. Change its speed or direction or both\r\n20. 20 m/s²\r\n19.  -2.5 m/s²\r\n\r\n	\N	2025-05-10 07:03:40.601815
303	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 07:03:48.481735
304	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8\r\n9a\r\n10\r\n11b\r\n12\r\n13d\r\n14a\r\n15c	\N	2025-05-10 07:03:52.495256
305	11		\N	2025-05-10 07:03:53.316737
306	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B 	\N	2025-05-10 07:04:04.084135
307	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n12. 3.6 m/s²\r\n13.s=vt+½at²\r\n14. 50 km/h\r\n15. Change its speed or direction or both\r\n20. 20 m/s²\r\n19.  -2.5 m/s²\r\n\r\n	\N	2025-05-10 07:04:09.98343
308	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 07:04:18.291004
309	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 07:04:18.504633
310	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 07:04:18.715454
311	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8\r\n9a\r\n10\r\n11b\r\n12\r\n13d\r\n14a\r\n15c	\N	2025-05-10 07:04:21.962626
312	11		\N	2025-05-10 07:04:23.320943
313	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B 	\N	2025-05-10 07:04:34.082167
500	10		\N	2025-05-13 09:54:32.174421
501	10		\N	2025-05-13 09:55:02.203803
502	10		\N	2025-05-13 09:55:32.929408
314	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n12. 3.6 m/s²\r\n13.s=vt+½at²\r\n14. 50 km/h\r\n15. Change its speed or direction or both\r\n20. 20 m/s²\r\n19.  -2.5 m/s²\r\n\r\n	\N	2025-05-10 07:04:40.155167
315	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 07:04:47.313499
316	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8a\r\n9a\r\n10\r\n11b\r\n12\r\n13d\r\n14a\r\n15c	\N	2025-05-10 07:04:51.531045
317	11		\N	2025-05-10 07:04:53.336457
318	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B 	\N	2025-05-10 07:05:04.290981
319	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n12. 3.6 m/s²\r\n13.s=vt+½at²\r\n14. 50 km/h\r\n15. Change its speed or direction or both\r\n20. 20 m/s²\r\n19.  -2.5 m/s²\r\n18.\r\n	\N	2025-05-10 07:05:10.246421
320	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 07:05:17.321321
321	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 07:05:18.213099
322	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8a\r\n9a\r\n10\r\n11b\r\n12\r\n13d\r\n14a\r\n15c	\N	2025-05-10 07:05:21.398562
323	11		\N	2025-05-10 07:05:23.422732
324	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B 	\N	2025-05-10 07:05:34.128255
325	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n12. 3.6 m/s²\r\n13.s=vt+½at²\r\n14. 50 km/h\r\n15. Change its speed or direction or both\r\n20. 20 m/s²\r\n19.  -2.5 m/s²\r\n18. 2 m/s²\r\n\r\n	\N	2025-05-10 07:05:40.24599
326	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 07:05:48.287508
327	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8a\r\n9a\r\n10\r\n11b\r\n12\r\n13d\r\n14a\r\n15c	\N	2025-05-10 07:05:51.898249
328	11		\N	2025-05-10 07:05:53.428916
329	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B 	\N	2025-05-10 07:06:04.103489
330	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n12. 3.6 m/s²\r\n13.s=vt+½at²\r\n14. 50 km/h\r\n15. Change its speed or direction or both\r\n20. 20 m/s²\r\n19.  -2.5 m/s²\r\n18. 2 m/s²\r\n17.\r\n	\N	2025-05-10 07:06:10.052634
331	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 07:06:18.269136
332	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8a\r\n9a\r\n10\r\n11b\r\n12\r\n13d\r\n14a\r\n15c	\N	2025-05-10 07:06:22.916407
333	11	IT FORMS	\N	2025-05-10 07:06:24.003481
334	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B 	\N	2025-05-10 07:06:34.172854
335	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n12. 3.6 m/s²\r\n13.s=vt+½at²\r\n14. 50 km/h\r\n15. Change its speed or direction or both\r\n20. 20 m/s²\r\n19.  -2.5 m/s²\r\n18. 2 m/s²\r\n17.\r\n	\N	2025-05-10 07:06:40.338646
336	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 07:06:47.332474
337	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8a\r\n9a\r\n10\r\n11b\r\n12\r\n13d\r\n14a\r\n15c	\N	2025-05-10 07:06:51.0824
338	11	IT FORMS VIRTUAL AND ERECT IMAGE \r\n2  	\N	2025-05-10 07:06:53.304585
339	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B 	\N	2025-05-10 07:07:04.308113
340	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n12. 3.6 m/s²\r\n13.s=vt+½at²\r\n14. 50 km/h\r\n15. Change its speed or direction or both\r\n20. 20 m/s²\r\n19.  -2.5 m/s²\r\n18. 2 m/s²\r\n17.\r\n	\N	2025-05-10 07:07:10.040104
341	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 07:07:18.265656
342	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8a\r\n9a\r\n10\r\n11b\r\n12\r\n13d\r\n14a\r\n15c\r\n20)18/m/s	\N	2025-05-10 07:07:21.554733
343	11	IT FORMS VIRTUAL AND ERECT IMAGE \r\n2  SECOND LAW OF REFLECTI	\N	2025-05-10 07:07:23.417021
344	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B 	\N	2025-05-10 07:07:34.700904
345	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n12. 3.6 m/s²\r\n13.s=vt+½at²\r\n14. 50 km/h\r\n15. Change its speed or direction or both\r\n20. 20 m/s²\r\n19.  -2.5 m/s²\r\n18. 2 m/s²\r\n17.\r\n	\N	2025-05-10 07:07:40.076794
346	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 07:07:48.259634
347	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8a\r\n9a\r\n10\r\n11b\r\n12\r\n13d\r\n14a\r\n15c\r\n20)18/m/s^2\r\n16)	\N	2025-05-10 07:07:51.418119
348	11	IT FORMS VIRTUAL AND ERECT IMAGE \r\n2  SECOND LAW OF REFLECTION \r\n3SLOWS DOWN \r\n4  CENTER 	\N	2025-05-10 07:07:53.301515
349	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B 	\N	2025-05-10 07:08:04.111763
350	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n12. 3.6 m/s²\r\n13.s=vt+½at²\r\n14. 50 km/h\r\n15. Change its speed or direction or both\r\n20. 20 m/s²\r\n19.  -2.5 m/s²\r\n18. 2 m/s²\r\n17.\r\n	\N	2025-05-10 07:08:10.65126
351	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 07:08:17.865641
352	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8a\r\n9a\r\n10\r\n11b\r\n12\r\n13d\r\n14a\r\n15c\r\n20)18/m/s^2\r\n16)	\N	2025-05-10 07:08:21.889169
353	11	IT FORMS VIRTUAL AND ERECT IMAGE \r\n2  SECOND LAW OF REFLECTION \r\n3SLOWS DOWN \r\n4  CENTER OF CURVATURE\r\n5  NO UNIT\r\n6 	\N	2025-05-10 07:08:23.53579
354	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B 	\N	2025-05-10 07:08:34.116983
355	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n12. 3.6 m/s²\r\n13.s=vt+½at²\r\n14. 50 km/h\r\n15. Change its speed or direction or both\r\n20. 20 m/s²\r\n19.  -2.5 m/s²\r\n18. 2 m/s²\r\n17.\r\n	\N	2025-05-10 07:08:40.253774
356	15	1)speed\r\n2)m/s\r\n	\N	2025-05-10 07:08:48.502472
357	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8a\r\n9a\r\n10\r\n11b\r\n12\r\n13d\r\n14a\r\n15c\r\n20)18/m/s^2\r\n16)	\N	2025-05-10 07:08:51.142792
358	11	IT FORMS VIRTUAL AND ERECT IMAGE \r\n2  SECOND LAW OF REFLECTION \r\n3SLOWS DOWN \r\n4  CENTER OF CURVATURE\r\n5  NO UNIT\r\n6 LIGHT TRAVLES 	\N	2025-05-10 07:08:53.423493
359	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B 	\N	2025-05-10 07:09:04.331484
360	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n12. 3.6 m/s²\r\n13.s=vt+½at²\r\n14. 50 km/h\r\n15. Change its speed or direction or both\r\n20. 20 m/s²\r\n19.  -2.5 m/s²\r\n18. 2 m/s²\r\n17.\r\n	\N	2025-05-10 07:09:10.804672
361	15	1)speed\r\n2)m/s\r\n3)covers equal distance 	\N	2025-05-10 07:09:17.417837
362	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8a\r\n9a\r\n10\r\n11b\r\n12\r\n13d\r\n14a\r\n15c\r\n20)18/m/s^2\r\n16)\r\n17)44m	\N	2025-05-10 07:09:21.16324
503	10		\N	2025-05-13 09:56:02.167643
504	10		\N	2025-05-13 09:56:32.419439
363	11	IT FORMS VIRTUAL AND ERECT IMAGE \r\n2  SECOND LAW OF REFLECTION \r\n3SLOWS DOWN \r\n4  CENTER OF CURVATURE\r\n5  NO UNIT\r\n6 LIGHT TRAVLES 1.33 TIMES FASTER 	\N	2025-05-10 07:09:23.427286
364	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B 	\N	2025-05-10 07:09:34.120586
365	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n12. 3.6 m/s²\r\n13.s=vt+½at²\r\n14. 50 km/h\r\n15. Change its speed or direction or both\r\n20. 20 m/s²\r\n19.  -2.5 m/s²\r\n18. 2 m/s²\r\n17.\r\n	\N	2025-05-10 07:09:40.201471
366	15	1)speed\r\n2)m/s\r\n3)covers equal distance in equal intervals of time \r\n4)	\N	2025-05-10 07:09:47.534661
367	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8a\r\n9a\r\n10\r\n11b\r\n12\r\n13d\r\n14a\r\n15c\r\n20)18/m/s^2\r\n16)\r\n17)44m	\N	2025-05-10 07:09:51.261762
368	11	IT FORMS VIRTUAL AND ERECT IMAGE \r\n2  SECOND LAW OF REFLECTION \r\n3SLOWS DOWN \r\n4  CENTER OF CURVATURE\r\n5  NO UNIT\r\n6 LIGHT TRAVLES 1.33 TIMES FASTER IN AIR THE	\N	2025-05-10 07:09:53.425676
369	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B 	\N	2025-05-10 07:10:04.116235
370	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n12. 3.6 m/s²\r\n13.s=vt+½at²\r\n14. 50 km/h\r\n15. Change its speed or direction or both\r\n20. 20 m/s²\r\n19.  -2.5 m/s²\r\n18. 2 m/s²\r\n17. 44 m\r\n\r\n	\N	2025-05-10 07:10:10.132282
371	15	1)speed\r\n2)m/s\r\n3)covers equal distance in equal intervals of time \r\n4)the object returne	\N	2025-05-10 07:10:17.825303
372	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8a\r\n9a\r\n10\r\n11b\r\n12\r\n13d\r\n14a\r\n15c\r\n20)18/m/s^2\r\n16)\r\n17)44m	\N	2025-05-10 07:10:21.848871
373	11	IT FORMS VIRTUAL AND ERECT IMAGE \r\n2  SECOND LAW OF REFLECTION \r\n3SLOWS DOWN \r\n4  CENTER OF CURVATURE\r\n5  NO UNIT\r\n6 LIGHT TRAVLES 1.33 TIMES FASTER IN AIR THEN WATER\r\n7 CONVEX MIRROR\r\n	\N	2025-05-10 07:10:23.450621
374	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B 	\N	2025-05-10 07:10:34.058607
375	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n12. 3.6 m/s²\r\n13.s=vt+½at²\r\n14. 50 km/h\r\n15. Change its speed or direction or both\r\n20. 20 m/s²\r\n19.  -2.5 m/s²\r\n18. 2 m/s²\r\n17. 44 m\r\n16.\r\n	\N	2025-05-10 07:10:40.587103
376	15	1)speed\r\n2)m/s\r\n3)covers equal distance in equal intervals of time \r\n4)the object returne of its initial position \r\n5) average 	\N	2025-05-10 07:10:47.565688
377	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8a\r\n9a\r\n10\r\n11b\r\n12\r\n13d\r\n14a\r\n15c\r\n20)18/m/s^2\r\n16)20m/s\r\n17)44m	\N	2025-05-10 07:10:51.324897
378	11	IT FORMS VIRTUAL AND ERECT IMAGE \r\n2  SECOND LAW OF REFLECTION \r\n3SLOWS DOWN \r\n4  CENTER OF CURVATURE\r\n5  NO UNIT\r\n6 LIGHT TRAVLES 1.33 TIMES FASTER IN AIR THEN WATER\r\n7 CONVEX MIRROR\r\n8 GLASS IS OPTICALLY DE	\N	2025-05-10 07:10:53.436573
379	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B 	\N	2025-05-10 07:11:05.077164
380	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n12. 3.6 m/s²\r\n13.s=vt+½at²\r\n14. 50 km/h\r\n15. Change its speed or direction or both\r\n20. 20 m/s²\r\n19.  -2.5 m/s²\r\n18. 2 m/s²\r\n17. 44 m\r\n16.\r\n	\N	2025-05-10 07:11:10.040516
381	15	1)speed\r\n2)m/s\r\n3)covers equal distance in equal intervals of time \r\n4)the object returne of its initial position \r\n5) average speed=total distance\r\n                              	\N	2025-05-10 07:11:17.340681
382	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8a\r\n9a\r\n10\r\n11b\r\n12\r\n13d\r\n14a\r\n15c\r\n20)18/m/s^2\r\n16)20m/s\r\n17)44meters	\N	2025-05-10 07:11:21.16094
383	11	IT FORMS VIRTUAL AND ERECT IMAGE \r\n2  SECOND LAW OF REFLECTION \r\n3SLOWS DOWN \r\n4  CENTER OF CURVATURE\r\n5  NO UNIT\r\n6 LIGHT TRAVLES 1.33 TIMES FASTER IN AIR THEN WATER\r\n7 CONVEX MIRROR\r\n8 GLASS IS OPTICALLY RARER\r\n9 IT PASSES WITH	\N	2025-05-10 07:11:23.679959
384	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B 	\N	2025-05-10 07:11:34.13603
385	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n12. 3.6 m/s²\r\n13.s=vt+½at²\r\n14. 50 km/h\r\n15. Change its speed or direction or both\r\n20. 20 m/s²\r\n19.  -2.5 m/s²\r\n18. 2 m/s²\r\n17. 44 m\r\n16.\r\n	\N	2025-05-10 07:11:40.83555
386	15	1)speed\r\n2)m/s\r\n3)covers equal distance in equal intervals of time \r\n4)the object returne of its initial position \r\n5) average speed	\N	2025-05-10 07:11:47.323462
387	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8a\r\n9a\r\n10\r\n11b\r\n12\r\n13d\r\n14a\r\n15c\r\n20)18/m/s^2\r\n16)20m/s\r\n17)44meters	\N	2025-05-10 07:11:51.677952
388	11	IT FORMS VIRTUAL AND ERECT IMAGE \r\n2  SECOND LAW OF REFLECTION \r\n3SLOWS DOWN \r\n4  CENTER OF CURVATURE\r\n5  NO UNIT\r\n6 LIGHT TRAVLES 1.33 TIMES FASTER IN AIR THEN WATER\r\n7 CONVEX MIRROR\r\n8 GLASS IS OPTICALLY RARER\r\n9 IT PASSES WITHOUT ANY DEVIATION \r\n10 REFRACT	\N	2025-05-10 07:11:54.043148
389	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B 	\N	2025-05-10 07:12:04.271033
390	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n12. 3.6 m/s²\r\n13.s=vt+½at²\r\n14. 50 km/h\r\n15. Change its speed or direction or both\r\n20. 20 m/s²\r\n19.  -2.5 m/s²\r\n18. 2 m/s²\r\n17. 44 m\r\n16.\r\n	\N	2025-05-10 07:12:09.957773
391	15	1)speed\r\n2)m/s\r\n3)covers equal distance in equal intervals of time \r\n4)the object returne of its initial position \r\n5) average speed = total distance ___	\N	2025-05-10 07:12:17.336311
392	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8a\r\n9a\r\n10\r\n11b\r\n12\r\n13d\r\n14a\r\n15c\r\n20)18/m/s^2\r\n16)20m/s\r\n17)44meters	\N	2025-05-10 07:12:21.100814
393	11	IT FORMS VIRTUAL AND ERECT IMAGE \r\n2  SECOND LAW OF REFLECTION \r\n3SLOWS DOWN \r\n4  CENTER OF CURVATURE\r\n5  NO UNIT\r\n6 LIGHT TRAVLES 1.33 TIMES FASTER IN AIR THEN WATER\r\n7 CONVEX MIRROR\r\n8 GLASS IS OPTICALLY RARER\r\n9 IT PASSES WITHOUT ANY DEVIATION \r\n10 REFRACTIVE INDEX INDICATES HOW MUCH LIGH	\N	2025-05-10 07:12:24.287497
394	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B 	\N	2025-05-10 07:12:34.041762
395	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n12. 3.6 m/s²\r\n13.s=vt+½at²\r\n14. 50 km/h\r\n15. Change its speed or direction or both\r\n20. 20 m/s²\r\n19.  -2.5 m/s²\r\n18. 2 m/s²\r\n17. 44 m\r\n16.\r\n	\N	2025-05-10 07:12:40.068373
396	15	1)speed\r\n2)m/s\r\n3)covers equal distance in equal intervals of time \r\n4)the object returne of its initial position \r\n5) average speed = total distance/total time \r\n                      	\N	2025-05-10 07:12:47.30359
397	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8a\r\n9a\r\n10\r\n11b\r\n12\r\n13d\r\n14a\r\n15c\r\n20)18/m/s^2\r\n16)20m/s\r\n17)44meters	\N	2025-05-10 07:12:51.82223
448	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8a\r\n9a\r\n10c\r\n11b\r\n12\r\n13d\r\n14a\r\n15c\r\n20)18/m/s^2\r\n16)20m/s\r\n17)44meters\r\n18)2m/s^2\r\n19)redardation=2.5m/s^2,distance covered=125m	\N	2025-05-10 07:18:04.943293
398	11	IT FORMS VIRTUAL AND ERECT IMAGE \r\n2  SECOND LAW OF REFLECTION \r\n3SLOWS DOWN \r\n4  CENTER OF CURVATURE\r\n5  NO UNIT\r\n6 LIGHT TRAVLES 1.33 TIMES FASTER IN AIR THEN WATER\r\n7 CONVEX MIRROR\r\n8 GLASS IS OPTICALLY RARER\r\n9 IT PASSES WITHOUT ANY DEVIATION \r\n10 REFRACTIVE INDEX INDICATES HOW MUCH LIGHT BENDS\r\n11 1.5\r\n12 	\N	2025-05-10 07:12:53.454791
399	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B 	\N	2025-05-10 07:13:04.370279
400	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n12. 3.6 m/s²\r\n13.s=vt+½at²\r\n14. 50 km/h\r\n15. Change its speed or direction or both\r\n20. 20 m/s²\r\n19.  -2.5 m/s²\r\n18. 2 m/s²\r\n17. 44 m\r\n16.\r\n	\N	2025-05-10 07:13:10.050459
401	15	1)speed\r\n2)m/s\r\n3)covers equal distance in equal intervals of time \r\n4)the object returne of its initial position \r\n5) average speed = total distance/total time \r\n                             60/2 \r\n                             30/1	\N	2025-05-10 07:13:17.319491
402	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8a\r\n9a\r\n10\r\n11b\r\n12\r\n13d\r\n14a\r\n15c\r\n20)18/m/s^2\r\n16)20m/s\r\n17)44meters\r\n18)2m/s	\N	2025-05-10 07:13:21.15166
403	11	IT FORMS VIRTUAL AND ERECT IMAGE \r\n2  SECOND LAW OF REFLECTION \r\n3SLOWS DOWN \r\n4  CENTER OF CURVATURE\r\n5  NO UNIT\r\n6 LIGHT TRAVLES 1.33 TIMES FASTER IN AIR THEN WATER\r\n7 CONVEX MIRROR\r\n8 GLASS IS OPTICALLY RARER\r\n9 IT PASSES WITHOUT ANY DEVIATION \r\n10 REFRACTIVE INDEX INDICATES HOW MUCH LIGHT BENDS\r\n11 1.5\r\n12 40\r\n13 2×10	\N	2025-05-10 07:13:23.988672
404	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B 	\N	2025-05-10 07:13:34.101001
405	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n12. 3.6 m/s²\r\n13.s=vt+½at²\r\n14. 50 km/h\r\n15. Change its speed or direction or both\r\n20. 20 m/s²\r\n19.  -2.5 m/s²\r\n18. 2 m/s²\r\n17. 44 m\r\n16.\r\n	\N	2025-05-10 07:13:40.823275
406	15	1)speed\r\n2)m/s\r\n3)covers equal distance in equal intervals of time \r\n4)the object returne of its initial position \r\n5) average speed = total distance/total time \r\n                             60/2 \r\n                             30/1 \r\n         = 30 km/h\r\n6	\N	2025-05-10 07:13:47.554473
407	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8a\r\n9a\r\n10\r\n11b\r\n12\r\n13d\r\n14a\r\n15c\r\n20)18/m/s^2\r\n16)20m/s\r\n17)44meters\r\n18)2m/s^2\r\n19)	\N	2025-05-10 07:13:51.848074
408	11	IT FORMS VIRTUAL AND ERECT IMAGE \r\n2  SECOND LAW OF REFLECTION \r\n3SLOWS DOWN \r\n4  CENTER OF CURVATURE\r\n5  NO UNIT\r\n6 LIGHT TRAVLES 1.33 TIMES FASTER IN AIR THEN WATER\r\n7 CONVEX MIRROR\r\n8 GLASS IS OPTICALLY RARER\r\n9 IT PASSES WITHOUT ANY DEVIATION \r\n10 REFRACTIVE INDEX INDICATES HOW MUCH LIGHT BENDS\r\n11 1.5\r\n12 40\r\n13 2×10^8\r\n14 120\r\n15 1.25\r\n	\N	2025-05-10 07:13:53.530701
409	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B 	\N	2025-05-10 07:14:04.09384
410	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n12. 3.6 m/s²\r\n13.s=vt+½at²\r\n14. 50 km/h\r\n15. Change its speed or direction or both\r\n20. 20 m/s²\r\n19.  -2.5 m/s²\r\n18. 2 m/s²\r\n17. 44 m\r\n16.20m/s\r\n	\N	2025-05-10 07:14:09.957475
411	15	1)speed\r\n2)m/s\r\n3)covers equal distance in equal intervals of time \r\n4)the object returne of its initial position \r\n5) average speed = total distance/total time \r\n                             60/2 \r\n                             30/1 \r\n         = 30 km/h\r\n6) displacement \r\n7) speed \r\n8) accelerate 	\N	2025-05-10 07:14:17.303775
412	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8a\r\n9a\r\n10\r\n11b\r\n12\r\n13d\r\n14a\r\n15c\r\n20)18/m/s^2\r\n16)20m/s\r\n17)44meters\r\n18)2m/s^2\r\n19)	\N	2025-05-10 07:14:21.79331
413	11	IT FORMS VIRTUAL AND ERECT IMAGE \r\n2  SECOND LAW OF REFLECTION \r\n3SLOWS DOWN \r\n4  CENTER OF CURVATURE\r\n5  NO UNIT\r\n6 LIGHT TRAVLES 1.33 TIMES FASTER IN AIR THEN WATER\r\n7 CONVEX MIRROR\r\n8 GLASS IS OPTICALLY RARER\r\n9 IT PASSES WITHOUT ANY DEVIATION \r\n10 REFRACTIVE INDEX INDICATES HOW MUCH LIGHT BENDS\r\n11 1.5\r\n12 40\r\n13 2×10^8\r\n14 120\r\n15 1.25\r\n16  V=-30	\N	2025-05-10 07:14:24.012674
414	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B 	\N	2025-05-10 07:14:34.14199
415	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n12. 3.6 m/s²\r\n13.s=vt+½at²\r\n14. 50 km/h\r\n15. Change its speed or direction or both\r\n20. 20 m/s²\r\n19.  -2.5 m/s²\r\n18. 2 m/s²\r\n17. 44 m\r\n16.20m/s\r\n	\N	2025-05-10 07:14:40.15454
416	15	1)speed\r\n2)m/s\r\n3)covers equal distance in equal intervals of time \r\n4)the object returne of its initial position \r\n5) average speed = total distance/total time \r\n                             60/2 \r\n                             30/1 \r\n         = 30 km/h\r\n6) displacement \r\n7) speed \r\n8) acceleration = final velocity - initial velocity \r\n	\N	2025-05-10 07:14:47.603388
417	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8a\r\n9a\r\n10\r\n11b\r\n12\r\n13d\r\n14a\r\n15c\r\n20)18/m/s^2\r\n16)20m/s\r\n17)44meters\r\n18)2m/s^2\r\n19)	\N	2025-05-10 07:14:52.22495
418	11	IT FORMS VIRTUAL AND ERECT IMAGE \r\n2  SECOND LAW OF REFLECTION \r\n3SLOWS DOWN \r\n4  CENTER OF CURVATURE\r\n5  NO UNIT\r\n6 LIGHT TRAVLES 1.33 TIMES FASTER IN AIR THEN WATER\r\n7 CONVEX MIRROR\r\n8 GLASS IS OPTICALLY RARER\r\n9 IT PASSES WITHOUT ANY DEVIATION \r\n10 REFRACTIVE INDEX INDICATES HOW MUCH LIGHT BENDS\r\n11 1.5\r\n12 40\r\n13 2×10^8\r\n14 120\r\n15 1.25\r\n16  V=-30 IMAGE IS REAL 	\N	2025-05-10 07:14:53.409484
419	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B 	\N	2025-05-10 07:15:04.361376
420	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n12. 3.6 m/s²\r\n13.s=vt+½at²\r\n14. 50 km/h\r\n15. Change its speed or direction or both\r\n20. 20 m/s²\r\n19.  -2.5 m/s²\r\n18. 2 m/s²\r\n17. 44 m\r\n16.20m/s\r\n	\N	2025-05-10 07:15:10.063093
421	15	1)speed\r\n2)m/s\r\n3)covers equal distance in equal intervals of time \r\n4)the object returne of its initial position \r\n5) average speed = total distance/total time \r\n                             60/2 \r\n                             30/1 \r\n         = 30 km/h\r\n6) displacement \r\n7) speed \r\n8) acceleration = final velocity - initial velocity /time \r\n       20-40/5	\N	2025-05-10 07:15:17.307095
422	11	IT FORMS VIRTUAL AND ERECT IMAGE \r\n2  SECOND LAW OF REFLECTION \r\n3SLOWS DOWN \r\n4  CENTER OF CURVATURE\r\n5  NO UNIT\r\n6 LIGHT TRAVLES 1.33 TIMES FASTER IN AIR THEN WATER\r\n7 CONVEX MIRROR\r\n8 GLASS IS OPTICALLY RARER\r\n9 IT PASSES WITHOUT ANY DEVIATION \r\n10 REFRACTIVE INDEX INDICATES HOW MUCH LIGHT BENDS\r\n11 1.5\r\n12 40\r\n13 2×10^8\r\n14 120\r\n15 1.25\r\n16  V=-30 IMAGE IS REAL INVERTED AND SAME SIZE\r\n17 	\N	2025-05-10 07:15:23.453255
423	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8a\r\n9a\r\n10\r\n11b\r\n12\r\n13d\r\n14a\r\n15c\r\n20)18/m/s^2\r\n16)20m/s\r\n17)44meters\r\n18)2m/s^2\r\n19)redardation=2.5m/s	\N	2025-05-10 07:15:33.997595
424	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B 	\N	2025-05-10 07:15:34.229085
505	10		\N	2025-05-13 09:57:02.741493
506	10		\N	2025-05-13 09:57:32.408586
507	10		\N	2025-05-13 09:58:02.20755
508	10		\N	2025-05-13 09:58:32.187081
509	10		\N	2025-05-13 09:59:02.196366
510	10		\N	2025-05-13 09:59:32.383867
425	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n12. 3.6 m/s²\r\n13.s=vt+½at²\r\n14. 50 km/h\r\n15. Change its speed or direction or both\r\n20. 20 m/s²\r\n19.  -2.5 m/s²\r\n18. 2 m/s²\r\n17. 44 m\r\n16.20m/s\r\n	\N	2025-05-10 07:15:41.030619
426	15	1)speed\r\n2)m/s\r\n3)covers equal distance in equal intervals of time \r\n4)the object returne of its initial position \r\n5) average speed = total distance/total time \r\n                             60/2 \r\n                             30/1 \r\n         = 30 km/h\r\n6) displacement \r\n7) speed \r\n8) acceleration = final velocity - initial velocity /time \r\n       20-40/5 \r\n      20/5 \r\n4	\N	2025-05-10 07:15:47.9279
427	11	IT FORMS VIRTUAL AND ERECT IMAGE \r\n2  SECOND LAW OF REFLECTION \r\n3SLOWS DOWN \r\n4  CENTER OF CURVATURE\r\n5  NO UNIT\r\n6 LIGHT TRAVLES 1.33 TIMES FASTER IN AIR THEN WATER\r\n7 CONVEX MIRROR\r\n8 GLASS IS OPTICALLY RARER\r\n9 IT PASSES WITHOUT ANY DEVIATION \r\n10 REFRACTIVE INDEX INDICATES HOW MUCH LIGHT BENDS\r\n11 1.5\r\n12 40\r\n13 2×10^8\r\n14 120\r\n15 1.25\r\n16  V=-30 IMAGE IS REAL INVERTED AND SAME SIZE\r\n17 V=30 \r\n18 	\N	2025-05-10 07:15:53.433826
428	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B 	\N	2025-05-10 07:16:04.27764
429	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8a\r\n9a\r\n10\r\n11b\r\n12\r\n13d\r\n14a\r\n15c\r\n20)18/m/s^2\r\n16)20m/s\r\n17)44meters\r\n18)2m/s^2\r\n19)redardation=2.5m/s^2,distance covered=	\N	2025-05-10 07:16:04.492929
430	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n12. 3.6 m/s²\r\n13.s=vt+½at²\r\n14. 50 km/h\r\n15. Change its speed or direction or both\r\n20. 20 m/s²\r\n19.  -2.5 m/s²\r\n18. 2 m/s²\r\n17. 44 m\r\n16.20m/s\r\n	\N	2025-05-10 07:16:10.610002
431	13	 1.  Speed\r\n2. m/s\r\n3. Cover equal distance in equal interval of time\r\n4. The object return to its initial position \r\n5. 30 km/h\r\n6. Displacement \r\n7. Speed \r\n8. 4 m/s²\r\n9. Displacement \r\n10. No acceleration\r\n11. Is zero\r\n12. 3.6 m/s²\r\n13.s=vt+½at²\r\n14. 50 km/h\r\n15. Change its speed or direction or both\r\n20. 20 m/s²\r\n19.  -2.5 m/s²\r\n18. 2 m/s²\r\n17. 44 m\r\n16.20m/s\r\n	\N	2025-05-10 07:16:11.330404
432	15	1)speed\r\n2)m/s\r\n3)covers equal distance in equal intervals of time \r\n4)the object returne of its initial position \r\n5) average speed = total distance/total time \r\n                             60/2 \r\n                             30/1 \r\n         = 30 km/h\r\n6) displacement \r\n7) speed \r\n8) acceleration = final velocity - initial velocity /time \r\n       20-40/5 \r\n      20/5 \r\n4m/s²\r\n9) di	\N	2025-05-10 07:16:17.332139
433	11	IT FORMS VIRTUAL AND ERECT IMAGE \r\n2  SECOND LAW OF REFLECTION \r\n3SLOWS DOWN \r\n4  CENTER OF CURVATURE\r\n5  NO UNIT\r\n6 LIGHT TRAVLES 1.33 TIMES FASTER IN AIR THEN WATER\r\n7 CONVEX MIRROR\r\n8 GLASS IS OPTICALLY RARER\r\n9 IT PASSES WITHOUT ANY DEVIATION \r\n10 REFRACTIVE INDEX INDICATES HOW MUCH LIGHT BENDS\r\n11 1.5\r\n12 40\r\n13 2×10^8\r\n14 120\r\n15 1.25\r\n16  V=-30 IMAGE IS REAL INVERTED AND SAME SIZE\r\n17 V=30 \r\n18 V=13.3 	\N	2025-05-10 07:16:23.44794
434	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8a\r\n9a\r\n10\r\n11b\r\n12\r\n13d\r\n14a\r\n15c\r\n20)18/m/s^2\r\n16)20m/s\r\n17)44meters\r\n18)2m/s^2\r\n19)redardation=2.5m/s^2,distance covered=125m	\N	2025-05-10 07:16:33.946852
435	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B 	\N	2025-05-10 07:16:34.207658
436	15	1)speed\r\n2)m/s\r\n3)covers equal distance in equal intervals of time \r\n4)the object returne of its initial position \r\n5) average speed = total distance/total time \r\n                             60/2 \r\n                             30/1 \r\n         = 30 km/h\r\n6) displacement \r\n7) speed \r\n8) acceleration = final velocity - initial velocity /time \r\n       20-40/5 \r\n      20/5 \r\n4m/s²\r\n9) displacement \r\n10) zero acceleration \r\n11) Is co	\N	2025-05-10 07:16:48.711041
437	11	IT FORMS VIRTUAL AND ERECT IMAGE \r\n2  SECOND LAW OF REFLECTION \r\n3SLOWS DOWN \r\n4  CENTER OF CURVATURE\r\n5  NO UNIT\r\n6 LIGHT TRAVLES 1.33 TIMES FASTER IN AIR THEN WATER\r\n7 CONVEX MIRROR\r\n8 GLASS IS OPTICALLY RARER\r\n9 IT PASSES WITHOUT ANY DEVIATION \r\n10 REFRACTIVE INDEX INDICATES HOW MUCH LIGHT BENDS\r\n11 1.5\r\n12 40\r\n13 2×10^8\r\n14 120\r\n15 1.25\r\n16  V=-30 IMAGE IS REAL INVERTED AND SAME SIZE\r\n17 V=30 \r\n18 V=13.3 IMAGE IS VIRTUAL ERECT\r\n19 	\N	2025-05-10 07:16:53.317302
438	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B 	\N	2025-05-10 07:17:04.081476
439	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8a\r\n9a\r\n10\r\n11b\r\n12\r\n13d\r\n14a\r\n15c\r\n20)18/m/s^2\r\n16)20m/s\r\n17)44meters\r\n18)2m/s^2\r\n19)redardation=2.5m/s^2,distance covered=125m	\N	2025-05-10 07:17:05.0196
440	15	1)speed\r\n2)m/s\r\n3)covers equal distance in equal intervals of time \r\n4)the object returne of its initial position \r\n5) average speed = total distance/total time \r\n                             60/2 \r\n                             30/1 \r\n         = 30 km/h\r\n6) displacement \r\n7) speed \r\n8) acceleration = final velocity - initial velocity /time \r\n       20-40/5 \r\n      20/5 \r\n4m/s²\r\n9) displacement \r\n10) zero acceleration \r\n11) Is constant \r\n12) acceleration = final velocity -in	\N	2025-05-10 07:17:17.848044
441	11	IT FORMS VIRTUAL AND ERECT IMAGE \r\n2  SECOND LAW OF REFLECTION \r\n3SLOWS DOWN \r\n4  CENTER OF CURVATURE\r\n5  NO UNIT\r\n6 LIGHT TRAVLES 1.33 TIMES FASTER IN AIR THEN WATER\r\n7 CONVEX MIRROR\r\n8 GLASS IS OPTICALLY RARER\r\n9 IT PASSES WITHOUT ANY DEVIATION \r\n10 REFRACTIVE INDEX INDICATES HOW MUCH LIGHT BENDS\r\n11 1.5\r\n12 40\r\n13 2×10^8\r\n14 120\r\n15 1.25\r\n16  V=-30 IMAGE IS REAL INVERTED AND SAME SIZE\r\n17 V=30 \r\n18 V=13.3 IMAGE IS VIRTUAL ERECT\r\n19 f=-15 cm\r\n20	\N	2025-05-10 07:17:23.581327
442	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8a\r\n9a\r\n10\r\n11b\r\n12\r\n13d\r\n14a\r\n15c\r\n20)18/m/s^2\r\n16)20m/s\r\n17)44meters\r\n18)2m/s^2\r\n19)redardation=2.5m/s^2,distance covered=125m	\N	2025-05-10 07:17:33.985797
443	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B 	\N	2025-05-10 07:17:34.201075
444	15	1)speed\r\n2)m/s\r\n3)covers equal distance in equal intervals of time \r\n4)the object returne of its initial position \r\n5) average speed = total distance/total time \r\n                             60/2 \r\n                             30/1 \r\n         = 30 km/h\r\n6) displacement \r\n7) speed \r\n8) acceleration = final velocity - initial velocity /time \r\n       20-40/5 \r\n      20/5 \r\n4m/s²\r\n9) displacement \r\n10) zero acceleration \r\n11) Is constant \r\n12) acceleration = final velocity -initial velocity/time \r\n     = 36-72/10 \r\n	\N	2025-05-10 07:17:47.541893
445	11	IT FORMS VIRTUAL AND ERECT IMAGE \r\n2  SECOND LAW OF REFLECTION \r\n3SLOWS DOWN \r\n4  CENTER OF CURVATURE\r\n5  NO UNIT\r\n6 LIGHT TRAVLES 1.33 TIMES FASTER IN AIR THEN WATER\r\n7 CONVEX MIRROR\r\n8 GLASS IS OPTICALLY RARER\r\n9 IT PASSES WITHOUT ANY DEVIATION \r\n10 REFRACTIVE INDEX INDICATES HOW MUCH LIGHT BENDS\r\n11 1.5\r\n12 40\r\n13 2×10^8\r\n14 120\r\n15 1.25\r\n16  V=-30 IMAGE IS REAL INVERTED AND SAME SIZE\r\n17 V=30 \r\n18 V=13.3 IMAGE IS VIRTUAL ERECT\r\n19 f=-15 cm\r\n20 f=16.6cm	\N	2025-05-10 07:17:53.485971
446	11	IT FORMS VIRTUAL AND ERECT IMAGE \r\n2  SECOND LAW OF REFLECTION \r\n3SLOWS DOWN \r\n4  CENTER OF CURVATURE\r\n5  NO UNIT\r\n6 LIGHT TRAVLES 1.33 TIMES FASTER IN AIR THEN WATER\r\n7 CONVEX MIRROR\r\n8 GLASS IS OPTICALLY RARER\r\n9 IT PASSES WITHOUT ANY DEVIATION \r\n10 REFRACTIVE INDEX INDICATES HOW MUCH LIGHT BENDS\r\n11 1.5\r\n12 40\r\n13 2×10^8\r\n14 120\r\n15 1.25\r\n16  V=-30 IMAGE IS REAL INVERTED AND SAME SIZE\r\n17 V=30 \r\n18 V=13.3 IMAGE IS VIRTUAL ERECT\r\n19 f=-15 cm\r\n20 f=16.6cm	\N	2025-05-10 07:18:03.572548
447	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B 	\N	2025-05-10 07:18:04.729512
449	15	1)speed\r\n2)m/s\r\n3)covers equal distance in equal intervals of time \r\n4)the object returne of its initial position \r\n5) average speed = total distance/total time \r\n                             60/2 \r\n                             30/1 \r\n         = 30 km/h\r\n6) displacement \r\n7) speed \r\n8) acceleration = final velocity - initial velocity /time \r\n       20-40/5 \r\n      20/5 \r\n4m/s²\r\n9) displacement \r\n10) zero acceleration \r\n11) Is constant \r\n12) acceleration = final velocity -initial velocity/time \r\n     = 36-72/10 \r\n     =36/10 \r\n                                       36	\N	2025-05-10 07:18:17.311381
450	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B 	\N	2025-05-10 07:18:34.170311
451	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8a\r\n9a\r\n10c\r\n11b\r\n12\r\n13d\r\n14a\r\n15c\r\n20)18/m/s^2\r\n16)20m/s\r\n17)44meters\r\n18)2m/s^2\r\n19)redardation=2.5m/s^2,distance covered=125m	\N	2025-05-10 07:18:35.086217
452	15	1)speed\r\n2)m/s\r\n3)covers equal distance in equal intervals of time \r\n4)the object returne of its initial position \r\n5) average speed = total distance/total time \r\n                             60/2 \r\n                             30/1 \r\n         = 30 km/h\r\n6) displacement \r\n7) speed \r\n8) acceleration = final velocity - initial velocity /time \r\n       20-40/5 \r\n      20/5 \r\n4m/s²\r\n9) displacement \r\n10) zero acceleration \r\n11) Is constant \r\n12) acceleration = final velocity -initial velocity/time \r\n     = 36-72/10 \r\n     =36/10 \r\n                                       36÷10=3.6\r\n\r\n       	\N	2025-05-10 07:18:47.550542
453	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8a\r\n9a\r\n10c\r\n11b\r\n12)12\r\n13d\r\n14a\r\n15c\r\n20)18/m/s^2\r\n16)20m/s\r\n17)44meters\r\n18)2m/s^2\r\n19)redardation=2.5m/s^2,distance covered=125m	\N	2025-05-10 07:19:04.192405
454	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B 	\N	2025-05-10 07:19:04.625324
455	15	1)speed\r\n2)m/s\r\n3)covers equal distance in equal intervals of time \r\n4)the object returne of its initial position \r\n5) average speed = total distance/total time \r\n                             60/2 \r\n                             30/1 \r\n         = 30 km/h\r\n6) displacement \r\n7) speed \r\n8) acceleration = final velocity - initial velocity /time \r\n       20-40/5 \r\n      20/5 \r\n4m/s²\r\n9) displacement \r\n10) zero acceleration \r\n11) Is constant \r\n12) acceleration = final velocity -initial velocity/time \r\n     = 36-72/10 \r\n     =36/10 \r\n                                       36÷10=3.6\r\n     =3.6 answer \r\n13) s/\r\n       	\N	2025-05-10 07:19:17.298112
456	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8a\r\n9a\r\n10c\r\n11b\r\n12)12959.99km/\r\n13d\r\n14a\r\n15c\r\n20)18/m/s^2\r\n16)20m/s\r\n17)44meters\r\n18)2m/s^2\r\n19)redardation=2.5m/s^2,distance covered=125m	\N	2025-05-10 07:19:34.007912
457	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B 	\N	2025-05-10 07:19:34.230089
458	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B 	\N	2025-05-10 07:20:04.24583
459	15	1)speed\r\n2)m/s\r\n3)covers equal distance in equal intervals of time \r\n4)the object returne of its initial position \r\n5) average speed = total distance/total time \r\n                             60/2 \r\n                             30/1 \r\n         = 30 km/h\r\n6) displacement \r\n7) speed \r\n8) acceleration = final velocity - initial velocity /time \r\n       20-40/5 \r\n      20/5 \r\n4m/s²\r\n9) displacement \r\n10) zero acceleration \r\n11) Is constant \r\n12) acceleration = final velocity -initial velocity/time \r\n     = 36-72/10 \r\n     =36/10 \r\n                                       36÷10=3.6\r\n     =3.6 answer \r\n13) s/vt+\r\n       	\N	2025-05-10 07:20:30.396798
460	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B 	\N	2025-05-10 07:20:34.102158
461	15	1)speed\r\n2)m/s\r\n3)covers equal distance in equal intervals of time \r\n4)the object returne of its initial position \r\n5) average speed = total distance/total time \r\n                             60/2 \r\n                             30/1 \r\n         = 30 km/h\r\n6) displacement \r\n7) speed \r\n8) acceleration = final velocity - initial velocity /time \r\n       20-40/5 \r\n      20/5 \r\n4m/s²\r\n9) displacement \r\n10) zero acceleration \r\n11) Is constant \r\n12) acceleration = final velocity -initial velocity/time \r\n     = 36-72/10 \r\n     =36/10 \r\n                                       36÷10=3.6\r\n     =3.6 answer \r\n13) s/vt+½at²\r\n14) a\r\n       	\N	2025-05-10 07:21:00.08052
462	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B 	\N	2025-05-10 07:21:04.07358
463	15	1)speed\r\n2)m/s\r\n3)covers equal distance in equal intervals of time \r\n4)the object returne of its initial position \r\n5) average speed = total distance/total time \r\n                             60/2 \r\n                             30/1 \r\n         = 30 km/h\r\n6) displacement \r\n7) speed \r\n8) acceleration = final velocity - initial velocity /time \r\n       20-40/5 \r\n      20/5 \r\n4m/s²\r\n9) displacement \r\n10) zero acceleration \r\n11) Is constant \r\n12) acceleration = final velocity -initial velocity/time \r\n     = 36-72/10 \r\n     =36/10 \r\n                                       36÷10=3.6\r\n     =3.6 answer \r\n13) s/vt+½at²\r\n14) avg speed=total distance/total time \r\n       	\N	2025-05-10 07:21:30.094762
464	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B) the obj 	\N	2025-05-10 07:21:34.110892
465	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8a\r\n9a\r\n10c\r\n11b\r\n12)12959.99km/ h\r\n13d\r\n14a\r\n15c\r\n20)18/m/s^2\r\n16)20m/s\r\n17)44meters\r\n18)2m/s^2\r\n19)redardation=2.5m/s^2,distance covered=125m	\N	2025-05-10 07:21:35.026756
466	15	1)speed\r\n2)m/s\r\n3)covers equal distance in equal intervals of time \r\n4)the object returne of its initial position \r\n5) average speed = total distance/total time \r\n                             60/2 \r\n                             30/1 \r\n         = 30 km/h\r\n6) displacement \r\n7) speed \r\n8) acceleration = final velocity - initial velocity /time \r\n       20-40/5 \r\n      20/5 \r\n4m/s²\r\n9) displacement \r\n10) zero acceleration \r\n11) Is constant \r\n12) acceleration = final velocity -initial velocity/time \r\n     = 36-72/10 \r\n     =36/10 \r\n                                       36÷10=3.6\r\n     =3.6 answer \r\n13) s/vt+½at²\r\n14) avg speed=total distance/total time \r\n        Distance=100+	\N	2025-05-10 07:22:00.099854
467	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B) the object returns to its initial position \r\n5  	\N	2025-05-10 07:22:04.386461
468	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8a\r\n9a\r\n10c\r\n11b\r\n12)12959.99km/ h\r\n13d\r\n14a\r\n15c\r\n20)18/m/s^2\r\n16)20m/s\r\n17)44meters\r\n18)2m/s^2\r\n19)redardation=2.5m/s^2,distance covered=125m	\N	2025-05-10 07:22:05.512452
469	15	1)speed\r\n2)m/s\r\n3)covers equal distance in equal intervals of time \r\n4)the object returne of its initial position \r\n5) average speed = total distance/total time \r\n                             60/2 \r\n                             30/1 \r\n         = 30 km/h\r\n6) displacement \r\n7) speed \r\n8) acceleration = final velocity - initial velocity /time \r\n       20-40/5 \r\n      20/5 \r\n4m/s²\r\n9) displacement \r\n10) zero acceleration \r\n11) Is constant \r\n12) acceleration = final velocity -initial velocity/time \r\n     = 36-72/10 \r\n     =36/10 \r\n                                       36÷10=3.6\r\n     =3.6 answer \r\n13) s/vt+½at²\r\n14) avg speed=total distance/total time \r\n        Distance=100+50 \r\n                           150km \r\n        Time =  2+1	\N	2025-05-10 07:22:30.315683
470	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B) the object returns to its initial position \r\n5 b ) 30 km / h\r\n6 b ) displacement 	\N	2025-05-10 07:22:34.690041
511	10		\N	2025-05-13 10:00:02.189257
512	10		\N	2025-05-13 10:00:32.168579
513	10		\N	2025-05-13 10:01:02.207825
514	10		\N	2025-05-13 10:01:32.627445
515	10		\N	2025-05-13 10:02:02.192712
471	15	1)speed\r\n2)m/s\r\n3)covers equal distance in equal intervals of time \r\n4)the object returne of its initial position \r\n5) average speed = total distance/total time \r\n                             60/2 \r\n                             30/1 \r\n         = 30 km/h\r\n6) displacement \r\n7) speed \r\n8) acceleration = final velocity - initial velocity /time \r\n       20-40/5 \r\n      20/5 \r\n4m/s²\r\n9) displacement \r\n10) zero acceleration \r\n11) Is constant \r\n12) acceleration = final velocity -initial velocity/time \r\n     = 36-72/10 \r\n     =36/10 \r\n                                       36÷10=3.6\r\n     =3.6 answer \r\n13) s/vt+½at²\r\n14) avg speed=total distance/total time \r\n        Distance=100+50 \r\n                           150km \r\n        Time =  2+1\r\n                   =3 hour \r\n                    \r\n                  =150/3	\N	2025-05-10 07:23:00.190044
472	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B) the object returns to its initial position \r\n5 b ) 30 km / h\r\n6 b ) displacement\r\n7 b speed\r\n8 a 4m/s \r\n 	\N	2025-05-10 07:23:04.097093
473	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8a\r\n9a\r\n10c\r\n11b\r\n12)12959.99km/ h\r\n13d\r\n14a\r\n15c\r\n20)18/m/s^2\r\n16)20m/s\r\n17)44meters\r\n18)2m/s^2\r\n19)redardation=2.5m/s^2,distance covered=125m	\N	2025-05-10 07:23:26.899133
474	15	1)speed\r\n2)m/s\r\n3)covers equal distance in equal intervals of time \r\n4)the object returne of its initial position \r\n5) average speed = total distance/total time \r\n                             60/2 \r\n                             30/1 \r\n         = 30 km/h\r\n6) displacement \r\n7) speed \r\n8) acceleration = final velocity - initial velocity /time \r\n       20-40/5 \r\n      20/5 \r\n4m/s²\r\n9) displacement \r\n10) zero acceleration \r\n11) Is constant \r\n12) acceleration = final velocity -initial velocity/time \r\n     = 36-72/10 \r\n     =36/10 \r\n                                       36÷10=3.6\r\n     =3.6 answer \r\n13) s/vt+½at²\r\n14) avg speed=total distance/total time \r\n        Distance=100+50 \r\n                           150km \r\n        Time =  2+1\r\n                   =3 hour \r\n                    \r\n                  =150/3 \r\n                   50 km/h \r\n15) covers 	\N	2025-05-10 07:23:30.100046
475	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B) the object returns to its initial position \r\n5 b ) 30 km / h\r\n6 b ) displacement\r\n7 b speed\r\n8 a 4m/s \r\n9a ) accerleration \r\n10 a cons 	\N	2025-05-10 07:23:34.163653
476	15	1)speed\r\n2)m/s\r\n3)covers equal distance in equal intervals of time \r\n4)the object returne of its initial position \r\n5) average speed = total distance/total time \r\n                             60/2 \r\n                             30/1 \r\n         = 30 km/h\r\n6) displacement \r\n7) speed \r\n8) acceleration = final velocity - initial velocity /time \r\n       20-40/5 \r\n      20/5 \r\n4m/s²\r\n9) displacement \r\n10) zero acceleration \r\n11) Is constant \r\n12) acceleration = final velocity -initial velocity/time \r\n     = 36-72/10 \r\n     =36/10 \r\n                                       36÷10=3.6\r\n     =3.6 answer \r\n13) s/vt+½at²\r\n14) avg speed=total distance/total time \r\n        Distance=100+50 \r\n                           150km \r\n        Time =  2+1\r\n                   =3 hour \r\n                    \r\n                  =150/3 \r\n                   50 km/h \r\n15) covers equal distance in equation \r\n	\N	2025-05-10 07:24:00.122736
477	15	1)speed\r\n2)m/s\r\n3)covers equal distance in equal intervals of time \r\n4)the object returne of its initial position \r\n5) average speed = total distance/total time \r\n                             60/2 \r\n                             30/1 \r\n         = 30 km/h\r\n6) displacement \r\n7) speed \r\n8) acceleration = final velocity - initial velocity /time \r\n       20-40/5 \r\n      20/5 \r\n4m/s²\r\n9) displacement \r\n10) zero acceleration \r\n11) Is constant \r\n12) acceleration = final velocity -initial velocity/time \r\n     = 36-72/10 \r\n     =36/10 \r\n                                       36÷10=3.6\r\n     =3.6 answer \r\n13) s/vt+½at²\r\n14) avg speed=total distance/total time \r\n        Distance=100+50 \r\n                           150km \r\n        Time =  2+1\r\n                   =3 hour \r\n                    \r\n                  =150/3 \r\n                   50 km/h \r\n15) covers equal distance in equation \r\n	\N	2025-05-10 07:24:00.791151
478	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B) the object returns to its initial position \r\n5 b ) 30 km / h\r\n6 b ) displacement\r\n7 b speed\r\n8 a 4m/s \r\n9a ) acceleration \r\n10 a constant speed but changing direction \r\n11  	\N	2025-05-10 07:24:04.094757
479	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8a\r\n9a\r\n10c\r\n11b\r\n12)12959.99km/ h\r\n13d\r\n14a\r\n15c\r\n20)18/m/s^2\r\n16)20m/s\r\n17)44meters\r\n18)2m/s^2\r\n19)redardation=2.5m/s^2,distance covered=125m	\N	2025-05-10 07:24:30.804684
480	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B) the object returns to its initial position \r\n5 b ) 30 km / h\r\n6 b ) displacement\r\n7 b speed\r\n8 a 4m/s \r\n9a ) acceleration \r\n10 a constant speed but changing direction \r\n11 b changes due to direction \r\n12 c 3.6 m/s\r\n 	\N	2025-05-10 07:24:34.094754
481	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B) the object returns to its initial position \r\n5 b ) 30 km / h\r\n6 b ) displacement\r\n7 b speed\r\n8 a 4m/s \r\n9a ) acceleration \r\n10 a constant speed but changing direction \r\n11 b changes due to direction \r\n12 c 3.6 m/s\r\n13 d s= vt + 	\N	2025-05-10 07:25:04.707664
482	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8a\r\n9a\r\n10c\r\n11b\r\n12)12959.99km/ h\r\n13d\r\n14a\r\n15c\r\n20)18/m/s^2\r\n16)20m/s\r\n17)44meters\r\n18)2m/s^2\r\n19)redardation=2.5m/s^2,distance covered=125m	\N	2025-05-10 07:25:30.457629
483	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B) the object returns to its initial position \r\n5 b ) 30 km / h\r\n6 b ) displacement\r\n7 b speed\r\n8 a 4m/s \r\n9a ) acceleration \r\n10 a constant speed but changing direction \r\n11 b changes due to direction \r\n12 c 3.6 m/s\r\n13 d s= vt +1/2 at 2 \r\n14 a \r\n16  	\N	2025-05-10 07:25:34.087394
484	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B) the object returns to its initial position \r\n5 b ) 30 km / h\r\n6 b ) displacement\r\n7 b speed\r\n8 a 4m/s \r\n9a ) acceleration \r\n10 a constant speed but changing direction \r\n11 b changes due to direction \r\n12 c 3.6 m/s\r\n13 d s= vt +1/2 at 2 \r\n14 a \r\n15 b \r\n16 v= 20 m/s\r\n17  	\N	2025-05-10 07:26:04.095928
485	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B) the object returns to its initial position \r\n5 b ) 30 km / h\r\n6 b ) displacement\r\n7 b speed\r\n8 a 4m/s \r\n9a ) acceleration \r\n10 a constant speed but changing direction \r\n11 b changes due to direction \r\n12 c 3.6 m/s\r\n13 d s= vt +1/2 at 2 \r\n14 a \r\n15 b \r\n16 v= 20 m/s\r\n17 s= 44m \r\n18a = 2\r\n 	\N	2025-05-10 07:26:34.097613
486	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B) the object returns to its initial position \r\n5 b ) 30 km / h\r\n6 b ) displacement\r\n7 b speed\r\n8 a 4m/s \r\n9a ) acceleration \r\n10 a constant speed but changing direction \r\n11 b changes due to direction \r\n12 c 3.6 m/s\r\n13 d s= vt +1/2 at 2 \r\n14 a \r\n15 b \r\n16 v= 20 m/s\r\n17 s= 44m \r\n18a = 2\r\n 	\N	2025-05-10 07:27:04.414441
487	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B) the object returns to its initial position \r\n5 b ) 30 km / h\r\n6 b ) displacement\r\n7 b speed\r\n8 a 4m/s \r\n9a ) acceleration \r\n10 a constant speed but changing direction \r\n11 b changes due to direction \r\n12 c 3.6 m/s\r\n13 d s= vt +1/2 at 2 \r\n14 a \r\n15 b \r\n16 v= 20 m/s\r\n17 s= 44m \r\n18a = 2\r\n 	\N	2025-05-10 07:27:34.098711
516	10		\N	2025-05-13 10:02:32.468123
517	10		\N	2025-05-13 10:03:02.240559
518	10		\N	2025-05-13 10:03:32.702712
519	10		\N	2025-05-13 10:04:02.180585
520	10		\N	2025-05-13 10:04:32.432802
488	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B) the object returns to its initial position \r\n5 b ) 30 km / h\r\n6 b ) displacement\r\n7 b speed\r\n8 a 4m/s \r\n9a ) acceleration \r\n10 a constant speed but changing direction \r\n11 b changes due to direction \r\n12 c 3.6 m/s\r\n13 d s= vt +1/2 at 2 \r\n14 a \r\n15 b \r\n16 v= 20 m/s\r\n17 s= 44m \r\n18a = 2\r\n 	\N	2025-05-10 07:28:04.330585
489	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B) the object returns to its initial position \r\n5 b ) 30 km / h\r\n6 b ) displacement\r\n7 b speed\r\n8 a 4m/s \r\n9a ) acceleration \r\n10 a constant speed but changing direction \r\n11 b changes due to direction \r\n12 c 3.6 m/s\r\n13 d s= vt +1/2 at 2 \r\n14 a \r\n15 b \r\n16 v= 20 m/s\r\n17 s= 44m \r\n18a = 2\r\n 	\N	2025-05-10 07:28:34.179944
490	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B) the object returns to its initial position \r\n5 b ) 30 km / h\r\n6 b ) displacement\r\n7 b speed\r\n8 a 4m/s \r\n9a ) acceleration \r\n10 a constant speed but changing direction \r\n11 b changes due to direction \r\n12 c 3.6 m/s\r\n13 d s= vt +1/2 at 2 \r\n14 a \r\n15 b \r\n16 v= 20 m/s\r\n17 s= 44m \r\n18a = 2\r\n 	\N	2025-05-10 07:29:04.651986
491	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B) the object returns to its initial position \r\n5 b ) 30 km / h\r\n6 b ) displacement\r\n7 b speed\r\n8 a 4m/s \r\n9a ) acceleration \r\n10 a constant speed but changing direction \r\n11 b changes due to direction \r\n12 c 3.6 m/s\r\n13 d s= vt +1/2 at 2 \r\n14 a \r\n15 b \r\n16 v= 20 m/s\r\n17 s= 44m \r\n18a = 2\r\n 	\N	2025-05-10 07:29:34.106594
492	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B) the object returns to its initial position \r\n5 b ) 30 km / h\r\n6 b ) displacement\r\n7 b speed\r\n8 a 4m/s \r\n9a ) acceleration \r\n10 a constant speed but changing direction \r\n11 b changes due to direction \r\n12 c 3.6 m/s\r\n13 d s= vt +1/2 at 2 \r\n14 a \r\n15 b \r\n16 v= 20 m/s\r\n17 s= 44m \r\n18a = 2\r\n 	\N	2025-05-10 07:30:04.099254
493	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B) the object returns to its initial position \r\n5 b ) 30 km / h\r\n6 b ) displacement\r\n7 b speed\r\n8 a 4m/s \r\n9a ) acceleration \r\n10 a constant speed but changing direction \r\n11 b changes due to direction \r\n12 c 3.6 m/s\r\n13 d s= vt +1/2 at 2 \r\n14 a \r\n15 b \r\n16 v= 20 m/s\r\n17 s= 44m \r\n18a = 2\r\n 	\N	2025-05-10 07:30:34.699413
494	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B) the object returns to its initial position \r\n5 b ) 30 km / h\r\n6 b ) displacement\r\n7 b speed\r\n8 a 4m/s \r\n9a ) acceleration \r\n10 a constant speed but changing direction \r\n11 b changes due to direction \r\n12 c 3.6 m/s\r\n13 d s= vt +1/2 at 2 \r\n14 a \r\n15 b \r\n16 v= 20 m/s\r\n17 s= 44m \r\n18a = 2\r\n 	\N	2025-05-10 07:31:04.116422
495	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B) the object returns to its initial position \r\n5 b ) 30 km / h\r\n6 b ) displacement\r\n7 b speed\r\n8 a 4m/s \r\n9a ) acceleration \r\n10 a constant speed but changing direction \r\n11 b changes due to direction \r\n12 c 3.6 m/s\r\n13 d s= vt +1/2 at 2 \r\n14 a \r\n15 b \r\n16 v= 20 m/s\r\n17 s= 44m \r\n18a = 2\r\n 	\N	2025-05-10 07:31:34.117354
496	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B) the object returns to its initial position \r\n5 b ) 30 km / h\r\n6 b ) displacement\r\n7 b speed\r\n8 a 4m/s \r\n9a ) acceleration \r\n10 a constant speed but changing direction \r\n11 b changes due to direction \r\n12 c 3.6 m/s\r\n13 d s= vt +1/2 at 2 \r\n14 a \r\n15 b \r\n16 v= 20 m/s\r\n17 s= 44m \r\n18a = 2\r\n19 i do 	\N	2025-05-10 07:32:04.175879
497	14	1 d ) speed\r\n2 b) m/s \r\n3 c) equal distance in equal intervals of time\r\n4)B) the object returns to its initial position \r\n5 b ) 30 km / h\r\n6 b ) displacement\r\n7 b speed\r\n8 a 4m/s \r\n9a ) acceleration \r\n10 a constant speed but changing direction \r\n11 b changes due to direction \r\n12 c 3.6 m/s\r\n13 d s= vt +1/2 at 2 \r\n14 a \r\n15 b \r\n16 v= 20 m/s\r\n17 s= 44m \r\n18a = 2\r\n19  ----\r\n20 a = 8  	\N	2025-05-10 07:32:24.703941
498	16	1d)\r\n2b\r\n3c\r\n4b\r\n5b\r\n6b\r\n7a\r\n8a\r\n9a\r\n10c\r\n11b\r\n12)12959.99km/ h\r\n13d\r\n14a\r\n15c\r\n20)18/m/s^2\r\n16)20m/s\r\n17)44meters\r\n18)2m/s^2\r\n19)redardation=2.5m/s^2,distance covered=125m\n\n[Note: This test expired while the student was away. The latest saved response has been automatically submitted.]	\N	2025-05-10 07:51:13.049601
521	10		\N	2025-05-13 10:05:02.171722
522	10		\N	2025-05-13 10:05:32.401263
523	10		\N	2025-05-13 10:06:02.202202
524	10		\N	2025-05-13 10:06:32.429658
525	10		\N	2025-05-13 10:07:02.240651
526	10		\N	2025-05-13 10:07:32.17308
527	10		\N	2025-05-13 10:08:02.221643
528	10		\N	2025-05-13 10:08:32.600701
529	10		\N	2025-05-13 10:09:02.276855
530	10		\N	2025-05-13 10:09:32.487521
531	10		\N	2025-05-13 10:10:02.280763
532	10		\N	2025-05-13 10:10:32.291387
533	10		\N	2025-05-13 10:11:02.264121
534	10		\N	2025-05-13 10:11:32.525843
535	10		\N	2025-05-13 10:12:02.256813
536	10		\N	2025-05-13 10:12:32.554085
537	10		\N	2025-05-13 10:13:02.267388
538	10		\N	2025-05-13 10:13:32.438506
539	10		\N	2025-05-13 10:14:02.263359
540	10		\N	2025-05-13 10:14:32.454373
541	10		\N	2025-05-13 10:15:02.271746
542	10		\N	2025-05-13 10:15:32.450492
543	10		\N	2025-05-13 10:16:02.304174
544	10		\N	2025-05-13 10:16:32.257495
545	10		\N	2025-05-13 10:17:02.265958
546	10		\N	2025-05-13 10:17:32.322865
547	10		\N	2025-05-13 10:18:02.298271
548	10		\N	2025-05-13 10:18:32.508846
549	10		\N	2025-05-13 10:19:02.333191
550	10		\N	2025-05-13 10:19:32.474635
551	10		\N	2025-05-13 10:20:02.857567
552	10		\N	2025-05-13 10:20:33.009805
553	10		\N	2025-05-13 10:21:02.316168
554	10		\N	2025-05-13 10:21:32.557773
555	10		\N	2025-05-13 10:22:02.293626
753	45	 Section A \n1. Cell\n2.cell wall\n	\N	2025-05-18 07:19:53.675588
754	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells the	\N	2025-05-18 07:19:57.873224
709	48	10c\n1110c\n11\n12b\n13a\n14c\n12b\n13a\n14c	\N	2025-05-18 07:10:43.340887
710	46	1 cell	\N	2025-05-18 07:10:57.928638
711	48	10c\n11\n12b\n14c	\N	2025-05-18 07:11:24.210748
712	46	1 cell\n2 cell wall	\N	2025-05-18 07:11:28.52966
713	46	1 cell\n2 cell wall\n3  mitochondria 	\N	2025-05-18 07:11:57.877129
715	46	1 cell\n2 cell wall\n3  mitochondria \n4 syn 	\N	2025-05-18 07:12:27.917492
716	48	1c\n2a\n3c\n4	\N	2025-05-18 07:12:30.704257
718	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein 	\N	2025-05-18 07:12:58.434448
719	48	1c\n2a\n3c\n4b\n5c\n6d\n7c\n8c\n9c\n10c\n11	\N	2025-05-18 07:13:00.693625
721	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi 	\N	2025-05-18 07:13:27.880206
722	48	1c\n2a\n3c\n4b\n5c\n6d\n7c\n8c\n9c\n10c\n11\n12b	\N	2025-05-18 07:13:30.754464
724	48	1c\n2a\n3c\n4b\n5c\n6d\n7c\n8c\n9c\n10c\n11a\n12b\n13	\N	2025-05-18 07:14:01.275245
725	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals 	\N	2025-05-18 07:14:04.017467
726	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n	\N	2025-05-18 07:14:27.859772
727	48	1c\n2a\n3c\n4b\n5c\n6d\n7c\n8c\n9c\n10c\n11a\n12b\n13a\n14b	\N	2025-05-18 07:14:30.701172
730	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 	\N	2025-05-18 07:14:58.606759
731	48	1c\n2a\n3c\n4b\n5c\n6d\n7c\n8c\n9c\n10c\n11a\n12b\n13a\n14b\n15b	\N	2025-05-18 07:15:00.710152
733	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a	\N	2025-05-18 07:15:27.833103
809	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribo	\N	2025-05-18 07:27:22.649745
810	47	1)cell\n2) cell wall \n3) mitochondria\n4) synthesis proteins\n5) cytoplasm\n6) gogli apparatus \n7) fungi\n8) nucleus\n9) plasmosis\n10)  ribosome\n          assertion and reason\n11)  both a and R are true and R is correct explaynation of a\n12) both end are true but I was not correct explanation of a\n13) both end are true and R is correct explanation of a\n14) both a and RR true and R is correct explanation of a\n15	\N	2025-05-18 07:27:30.690241
735	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation for a	\N	2025-05-18 07:16:22.65953
737	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation for a\n12\n	\N	2025-05-18 07:17:54.050617
739	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\nQ\n	\N	2025-05-18 07:18:18.796842
741	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and \n	\N	2025-05-18 07:18:20.607166
742	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n\n	\N	2025-05-18 07:18:21.520668
743	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the \n	\N	2025-05-18 07:18:27.822066
745	45	 Section A 	\N	2025-05-18 07:18:53.145362
746	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a \n	\N	2025-05-18 07:18:57.946036
687	24	1c\n2a\n3c\n4b\n5c\n	\N	2025-05-18 06:55:40.285641
690	24	1c\n2a\n3c\n4b\n5c\n6d\n7c\n8c\n9c\n10c	\N	2025-05-18 06:56:08.145731
694	24	1c\n2a\n3c\n4b\n5c\n6d\n7c\n8c\n9c\n10c\n11a\n12b\n13	\N	2025-05-18 06:56:37.371896
749	45	 Section A \n1. Cell\n2.	\N	2025-05-18 07:19:22.596538
750	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n	\N	2025-05-18 07:19:27.822711
757	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• 	\N	2025-05-18 07:20:28.450194
760	45	 Section A \n1. Cell\n2.cell wall\n3.	\N	2025-05-18 07:20:52.612954
761	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• 	\N	2025-05-18 07:20:57.830426
764	45	 Section A \n1. Cell\n2.cell wall\n3.mitro	\N	2025-05-18 07:21:23.200227
765	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not	\N	2025-05-18 07:21:27.842063
768	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4.	\N	2025-05-18 07:21:52.621091
769	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n• only a single chromosome \nEukaryotic 	\N	2025-05-18 07:22:03.978917
1122	102	under root 2 is an irrational number under root 3 is an irrational why they are irrational number because irrational number is defined as a number which can be written in the form of p by q where p and q are positive integers and q is not	\N	2025-05-25 21:17:12.277467
772	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n• only a single chromosome \nEukaryotic cells:- • the size of these cells are generally laeg	\N	2025-05-18 07:22:28.379527
775	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.\n6.\n7.\n8.9.\n10.	\N	2025-05-18 07:22:52.627074
776	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n• only a single chromosome \nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is 	\N	2025-05-18 07:22:57.941205
1062	75	your sample is very good I like your sample very much it looks like byju's APP channel	\N	2025-05-22 07:09:17.799111
779	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.\n6.\n7.\n8.\n9.\n10.	\N	2025-05-18 07:23:22.765894
780	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n• only a single chromosome \nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined 	\N	2025-05-18 07:23:28.445119
782	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n• only a single chromosome \nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 	\N	2025-05-18 07:23:57.839528
783	47	1)\n2) cell	\N	2025-05-18 07:24:00.685891
785	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.c\n6.\n7.\n8.\n9.\n10.	\N	2025-05-18 07:24:22.570684
786	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n• only a single chromosome \nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n•  	\N	2025-05-18 07:24:27.826762
787	47	1)cell\n2) cell wall \n3) mitochondria\n4)	\N	2025-05-18 07:24:30.636495
789	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.\n7.\n8.\n9.\n10.	\N	2025-05-18 07:24:52.672348
1068	57	Haider how are you	\N	2025-05-24 04:47:29.147523
1069	23	hey this is my working I think it is I said something and it immediately transcript when I said	\N	2025-05-24 04:50:48.496834
1070	23	hey this is my working I think it is I said something and it immediately transcript when I said very large scale test on this platform saying it can be extended to become like a shop of experience	\N	2025-05-24 04:51:18.575082
790	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 	\N	2025-05-18 07:24:57.8977
791	47	1)cell\n2) cell wall \n3) mitochondria\n4) synthesis proteins\n5) cytoplasm \n6	\N	2025-05-18 07:25:01.251085
793	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.\n8.\n9.\n10.	\N	2025-05-18 07:25:22.643727
794	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell fr	\N	2025-05-18 07:25:27.831361
795	47	1)cell\n2) cell wall \n3) mitochondria\n4) synthesis proteins\n5) cytoplasm\n6) gogli apparatus \n7	\N	2025-05-18 07:25:30.686785
797	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.pla\n8.\n9.\n10.	\N	2025-05-18 07:25:52.588227
798	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter o	\N	2025-05-18 07:25:57.84315
799	47	1)cell\n2) cell wall \n3) mitochondria\n4) synthesis proteins\n5) cytoplasm\n6) gogli apparatus \n7) fungi\n8) nucleus\n9) plasmosis	\N	2025-05-18 07:26:00.677185
801	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8.\n9.\n10.	\N	2025-05-18 07:26:22.713006
802	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell 	\N	2025-05-18 07:26:27.824375
803	47	1)cell\n2) cell wall \n3) mitochondria\n4) synthesis proteins\n5) cytoplasm\n6) gogli apparatus \n7) fungi\n8) nucleus\n9) plasmosis\n10)  ribosome\n          assertion and reason\n11	\N	2025-05-18 07:26:31.241899
1074	85	han ji hello this is my answer please give me full marks	\N	2025-05-25 12:45:30.693758
805	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmo\n10.	\N	2025-05-18 07:26:52.745182
806	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane 	\N	2025-05-18 07:26:58.405733
807	47	1)cell\n2) cell wall \n3) mitochondria\n4) synthesis proteins\n5) cytoplasm\n6) gogli apparatus \n7) fungi\n8) nucleus\n9) plasmosis\n10)  ribosome\n          assertion and reason\n11)  both a and R are true and R is correct explaynation of a\n12) both end are true but I was not correct explanation of a\n1	\N	2025-05-18 07:27:00.686981
1075	85	han ji hello this is my answer please give me full marks han ji Maine Jo bola na vah fatafat se type kar do	\N	2025-05-25 12:47:00.382726
1076	89	1.	\N	2025-05-25 15:06:07.183005
1077	89	1. Non term	\N	2025-05-25 15:08:20.602459
1078	89	1. Non terminating and repeating\n2.	\N	2025-05-25 15:08:39.165384
1079	89	1. Non terminating and repeating\n2.3/4\n3.	\N	2025-05-25 15:09:16.507785
1080	89	1. Non terminating and repeating\n2.3/4\n3.always rational	\N	2025-05-25 15:09:50.498743
1081	89	1. Non terminating and repeating\n2.3/4\n3.always rational\n4.	\N	2025-05-25 15:09:57.473308
1082	89	1. Non terminating and repeating\n2.3/4\n3.always rational\n4.0\n5.	\N	2025-05-25 15:13:49.059891
1083	89	1. Non terminating and repeating\n2.3/4\n3.always rational\n4.0\n5.4\n6.	\N	2025-05-25 15:14:22.970786
1084	89	1. Non terminating and repeating\n2.3/4\n3.always rational\n4.0\n5.4\n6.3\n7.	\N	2025-05-25 15:15:13.207692
811	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall 	\N	2025-05-18 07:27:33.40791
812	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.	\N	2025-05-18 07:27:53.140604
813	47	1)cell\n2) cell wall \n3) mitochondria\n4) synthesis proteins\n5) cytoplasm\n6) gogli apparatus \n7) fungi\n8) nucleus\n9) plasmosis\n10)  ribosome\n          assertion and reason\n11)  both a and R are true and R is correct explaynation of a\n12) both end are true but I was not correct explanation of a\n13) both end are true and R is correct explanation of a\n14) both a and RR true and R is correct explanation of a\n15)  he is true but R false\n            Section C\n        	\N	2025-05-18 07:28:00.667547
814	47	1)cell\n2) cell wall \n3) mitochondria\n4) synthesis proteins\n5) cytoplasm\n6) gogli apparatus \n7) fungi\n8) nucleus\n9) plasmosis\n10)  ribosome\n          assertion and reason\n11)  both a and R are true and R is correct explaynation of a\n12) both end are true but I was not correct explanation of a\n13) both end are true and R is correct explanation of a\n14) both a and RR true and R is correct explanation of a\n15)  he is true but R false\n            Section C\n         short question answers \n prokaryotic cell=  size journalist Mall (1 - 10 UN bracket and	\N	2025-05-18 07:28:30.695981
1085	89	1. Non terminating and repeating\n2.3/4\n3.always rational\n4.0\n5.4\n6.3\n7.a\n8.	\N	2025-05-25 15:15:47.948647
816	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \n	\N	2025-05-18 07:28:57.816197
817	47	1)cell\n2) cell wall \n3) mitochondria\n4) synthesis proteins\n5) cytoplasm\n6) gogli apparatus \n7) fungi\n8) nucleus\n9) plasmosis\n10)  ribosome\n          assertion and reason\n11)  both a and R are true and R is correct explaynation of a\n12) both end are true but I was not correct explanation of a\n13) both end are true and R is correct explanation of a\n14) both a and RR true and R is correct explanation of a\n15)  he is true but R false\n            Section C\n         short question answers \n prokaryotic cell=  size gene	\N	2025-05-18 07:29:01.045357
1086	89	1. Non terminating and repeating\n2.3/4\n3.always rational\n4.0\n5.4\n6.3\n7.a\n8.3\n9.	\N	2025-05-25 15:16:20.242339
819	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucopla\n	\N	2025-05-18 07:29:28.367652
820	47	1)cell\n2) cell wall \n3) mitochondria\n4) synthesis proteins\n5) cytoplasm\n6) gogli apparatus \n7) fungi\n8) nucleus\n9) plasmosis\n10)  ribosome\n          assertion and reason\n11)  both a and R are true and R is correct explaynation of a\n12) both end are true but I was not correct explanation of a\n13) both end are true and R is correct explanation of a\n14) both a and RR true and R is correct explanation of a\n15)  he is true but R false\n            Section C\n         short question answers \n prokaryotic cell=  size generally small (1-10um);and \n   	\N	2025-05-18 07:29:31.2411
1087	89	1. Non terminating and repeating\n2.3/4\n3.always rational\n4.0\n5.4\n6.3\n7.a\n8.3\n9.x+1	\N	2025-05-25 15:18:26.572724
1088	89	1. Non terminating and repeating\n2.3/4\n3.always rational\n4.0\n5.4\n6.3\n7.a\n8.3\n9.x+1\n1	\N	2025-05-25 15:18:40.661423
1089	89	1. Non terminating and repeating\n2.3/4\n3.always rational\n4.0\n5.4\n6.3\n7.a\n8.3\n9.x+1\n10.	\N	2025-05-25 15:18:48.561509
1090	89	1. Non terminating and repeating\n2.3/4\n3.always rational\n4.0\n5.4\n6.3\n7.a\n8.3\n9.x+1\n10.(X	\N	2025-05-25 15:21:26.554266
1091	89	1. Non terminating and repeating\n2.3/4\n3.always rational\n4.0\n5.4\n6.3\n7.a\n8.3\n9.x+1\n10.(x,y)\n11.	\N	2025-05-25 15:21:44.561818
1092	89	1. Non terminating and repeating\n2.3/4\n3.always rational\n4.0\n5.4\n6.3\n7.a\n8.3\n9.x+1\n10.(x,y)\n11.quadrant 2	\N	2025-05-25 15:22:26.586593
1093	89	1. Non terminating and repeating\n2.3/4\n3.always rational\n4.0\n5.4\n6.3\n7.a\n8.3\n9.x+1\n10.(x,y)\n11.quadrant 2\n12.	\N	2025-05-25 15:22:34.755504
1094	89	1. Non terminating and repeating\n2.3/4\n3.always rational\n4.0\n5.4\n6.3\n7.a\n8.3\n9.x+1\n10.(x,y)\n11.quadrant 2\n12.origin	\N	2025-05-25 15:22:56.356555
1095	89	1. Non terminating and repeating\n2.3/4\n3.always rational\n4.0\n5.4\n6.3\n7.a\n8.3\n9.x+1\n10.(x,y)\n11.quadrant 2\n12.origin\n13.	\N	2025-05-25 15:23:06.767843
1096	89	1. Non terminating and repeating\n2.3/4\n3.always rational\n4.0\n5.4\n6.3\n7.a\n8.3\n9.x+1\n10.(x,y)\n11.quadrant 2\n12.origin\n13.0\n14.	\N	2025-05-25 15:23:47.337819
1097	89	1. Non terminating and repeating\n2.3/4\n3.always rational\n4.0\n5.4\n6.3\n7.a\n8.3\n9.x+1\n10.(x,y)\n11.quadrant 2\n12.origin\n13.0\n14.-5\n15.	\N	2025-05-25 15:24:10.728496
1098	89	1. Non terminating and repeating\n2.3/4\n3.always rational\n4.0\n5.4\n6.3\n7.a\n8.3\n9.x+1\n10.(x,y)\n11.quadrant 2\n12.origin\n13.0\n14.-5\n15.7\n16.	\N	2025-05-25 15:24:25.507955
822	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\n\n	\N	2025-05-18 07:29:57.899377
823	49	the following are the functions of the plasma membrane	\N	2025-05-18 07:30:00.223413
824	47	1)cell\n2) cell wall \n3) mitochondria\n4) synthesis proteins\n5) cytoplasm\n6) gogli apparatus \n7) fungi\n8) nucleus\n9) plasmosis\n10)  ribosome\n          assertion and reason\n11)  both a and R are true and R is correct explaynation of a\n12) both end are true but I was not correct explanation of a\n13) both end are true and R is correct explanation of a\n14) both a and RR true and R is correct explanation of a\n15)  he is true but R false\n            Section C\n         short question answers \n prokaryotic cell=  size generally small (1-10um);and \n                                        1um =10 power of minus 6m\n    	\N	2025-05-18 07:30:00.703843
1099	89	1. Non terminating and repeating\n2.3/4\n3.always rational\n4.0\n5.4\n6.3\n7.a\n8.3\n9.x+1\n10.(x,y)\n11.quadrant 2\n12.origin\n13.0\n14.-5\n15.7\n16.1	\N	2025-05-25 15:24:56.72367
857	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not corre	\N	2025-05-18 07:34:22.661153
826	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are \n	\N	2025-05-18 07:30:27.863447
827	49	the following are the functions of the plasma membrane the plasma membrane is called the selectivali vermiable membrane as it allows only the selective materials to come inside and go outside from the membrane it protects the cell	\N	2025-05-18 07:30:30.224105
828	47	1)cell\n2) cell wall \n3) mitochondria\n4) synthesis proteins\n5) cytoplasm\n6) gogli apparatus \n7) fungi\n8) nucleus\n9) plasmosis\n10)  ribosome\n          assertion and reason\n11)  both a and R are true and R is correct explaynation of a\n12) both end are true but I was not correct explanation of a\n13) both end are true and R is correct explanation of a\n14) both a and RR true and R is correct explanation of a\n15)  he is true but R false\n            Section C\n         short question answers \n prokaryotic cell=  size generally small (1-10um);and \n                                        1um =10 power of minus 6m\n           2)  nuclear region and find due to the absence of nuclear membrane are known as newcollide	\N	2025-05-18 07:30:30.693238
1100	89	1. Non terminating and repeating\n2.3/4\n3.always rational\n4.0\n5.4\n6.3\n7.a\n8.3\n9.x+1\n10.(x,y)\n11.quadrant 2\n12.origin\n13.0\n14.-5\n15.7\n16.1/x+x\n17.	\N	2025-05-25 15:25:15.733564
830	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19\n	\N	2025-05-18 07:30:57.842212
831	49	the following are the functions of the plasma membrane the plasma membrane is called the selectivali vermiable membrane as it allows only the selective materials to come inside and go outside from the membrane it protects the cell from the harmful substances to come inside the cell it do not allow the important interior substances to go move outside the cell	\N	2025-05-18 07:31:00.211239
832	47	1)cell\n2) cell wall \n3) mitochondria\n4) synthesis proteins\n5) cytoplasm\n6) gogli apparatus \n7) fungi\n8) nucleus\n9) plasmosis\n10)  ribosome\n          assertion and reason\n11)  both a and R are true and R is correct explaynation of a\n12) both end are true but I was not correct explanation of a\n13) both end are true and R is correct explanation of a\n14) both a and RR true and R is correct explanation of a\n15)  he is true but R false\n            Section C\n         short question answers \n prokaryotic cell=  size generally small (1-10um);and \n                                        1um =10 power of minus 6m\n           2)  nuclear region undefined \ndue to the absence of nuclear membrane are known as nucleoid \n	\N	2025-05-18 07:31:00.699681
1101	89	1. Non terminating and repeating\n2.3/4\n3.always rational\n4.0\n5.4\n6.3\n7.a\n8.3\n9.x+1\n10.(x,y)\n11.quadrant 2\n12.origin\n13.0\n14.-5\n15.7\n16.1/x+x\n17.q	\N	2025-05-25 15:25:52.505342
1102	89	1. Non terminating and repeating\n2.3/4\n3.always rational\n4.0\n5.4\n6.3\n7.a\n8.3\n9.x+1\n10.(x,y)\n11.quadrant 2\n12.origin\n13.0\n14.-5\n15.7\n16.1/x+x\n17.0\n18\n	\N	2025-05-25 15:26:40.733272
1103	89	1. Non terminating and repeating\n2.3/4\n3.always rational\n4.0\n5.4\n6.3\n7.a\n8.3\n9.x+1\n10.(x,y)\n11.quadrant 2\n12.origin\n13.0\n14.-5\n15.7\n16.1/x+x\n17.0\n18 . Constant \n19.\n	\N	2025-05-25 15:35:20.749146
1104	89	1. Non terminating and repeating\n2.3/4\n3.always rational\n4.0\n5.4\n6.3\n7.a\n8.3\n9.x+1\n10.(x,y)\n11.quadrant 2\n12.origin\n13.0\n14.-5\n15.7\n16.1/x+x\n17.0\n18 . Constant \n19.0 \n20.\n	\N	2025-05-25 15:36:11.983819
1105	89	1. Non terminating and repeating\n2.3/4\n3.always rational\n4.0\n5.4\n6.3\n7.a\n8.3\n9.x+1\n10.(x,y)\n11.quadrant 2\n12.origin\n13.0\n14.-5\n15.7\n16.1/x+x\n17.0\n18 . Constant \n19.0 \n20. -3,-2\n	\N	2025-05-25 15:36:42.612366
1106	89	 1. Non terminating and repeating\n2.3/4\n3.always rational\n4.0\n5.4\n6.3\n7.a\n8.3\n9.x+1\n10.(x,y)\n11.quadrant 2\n12.origin\n13.0\n14.-5\n15.7\n16.1/x+x\n17.0\n18 . Constant \n19.0 \n20. -3,-2\n	\N	2025-05-25 15:36:56.308704
834	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are 	\N	2025-05-18 07:31:23.240911
835	49	the following are the functions of the plasma membrane the plasma membrane is called the selectivali vermiable membrane as it allows only the selective materials to come inside and go outside from the membrane it protects the cell from the harmful substances to come inside the cell it do not allow the important interior substances to go move outside the cell it is also called the protective layer of the cell second question difference between a Plant cell and Animal cell	\N	2025-05-18 07:31:30.64684
836	47	1)cell\n2) cell wall \n3) mitochondria\n4) synthesis proteins\n5) cytoplasm\n6) gogli apparatus \n7) fungi\n8) nucleus\n9) plasmosis\n10)  ribosome\n          assertion and reason\n11)  both a and R are true and R is correct explaynation of a\n12) both end are true but I was not correct explanation of a\n13) both end are true and R is correct explanation of a\n14) both a and RR true and R is correct explanation of a\n15)  he is true but R false\n            Section C\n         short question answers \n prokaryotic cell=  size generally small (1-10um);and \n                                        1um =10 power of minus 6m\n           2)  nuclear region undefined due to the absence of nuclear membrane are known as nucleoid \n           3) rhizooms is of 70s type	\N	2025-05-18 07:31:30.884981
1107	89	 Section A \n1. Non terminating and repeating\n2.3/4\n3.always rational\n4.0\n5.4\n6.3\n7.a\n8.3\n9.x+1\n10.(x,y)\n11.quadrant 2\n12.origin\n13.0\n14.-5\n15.7\n16.1/x+x\n17.0\n18 . Constant \n19.0 \n20. -3,-2\n	\N	2025-05-25 15:37:05.270137
838	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is 	\N	2025-05-18 07:31:52.72124
839	49	the following are the functions of the plasma membrane the plasma membrane is called the selectivali vermiable membrane as it allows only the selective materials to come inside and go outside from the membrane it protects the cell from the harmful substances to come inside the cell it do not allow the important interior substances to go move outside the cell it is also called the protective layer of the cell .	\N	2025-05-18 07:32:00.099423
840	47	1)cell\n2) cell wall \n3) mitochondria\n4) synthesis proteins\n5) cytoplasm\n6) gogli apparatus \n7) fungi\n8) nucleus\n9) plasmosis\n10)  ribosome\n          assertion and reason\n11)  both a and R are true and R is correct explaynation of a\n12) both end are true but I was not correct explanation of a\n13) both end are true and R is correct explanation of a\n14) both a and RR true and R is correct explanation of a\n15)  he is true but R false\n            Section C\n         short question answers \n prokaryotic cell=  size generally small (1-10um);and \n                                        1um =10 power of minus 6m\n           2)  nuclear region undefined due to the absence of nuclear membrane are known as nucleoid \n           3) rhizooms is of 70s type\nE	\N	2025-05-18 07:32:01.228353
841	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  	\N	2025-05-18 07:32:22.485392
842	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the con\n	\N	2025-05-18 07:32:28.394867
843	49	the following are the functions of the plasma membrane the plasma membrane is called the selectivali vermiable membrane as it allows only the selective materials to come inside and go outside from the membrane it protects the cell from the harmful substances to come inside the cell it do not allow the important interior substances to go move outside the cell it is also called the protective layer of the cell .\n2) difference between a Plant cell and Animal cell	\N	2025-05-18 07:32:30.56342
844	47	1)cell\n2) cell wall \n3) mitochondria\n4) synthesis proteins\n5) cytoplasm\n6) gogli apparatus \n7) fungi\n8) nucleus\n9) plasmosis\n10)  ribosome\n          assertion and reason\n11)  both a and R are true and R is correct explaynation of a\n12) both end are true but I was not correct explanation of a\n13) both end are true and R is correct explanation of a\n14) both a and RR true and R is correct explanation of a\n15)  he is true but R false\n            Section C\n         short question answers \n prokaryotic cell=  size generally small (1-10um);and \n                                        1um =10 power of minus 6m\n           2)  nuclear region undefined due to the absence of nuclear membrane are known as nucleoid \n           3) rhizooms is of 70s type\nEukarytic cell 1) cell generally large (5 - 100 Un	\N	2025-05-18 07:32:30.800975
845	47		\N	2025-05-18 07:32:41.42383
1108	89	 Section A \n1. Non terminating and repeating\n2.3/4\n3.always rational\n4.0\n5.4\n6.3\n7.a\n8.3\n9.x+1\n10.(x,y)\n11.quadrant 2\n12.origin\n13.0\n14.-5\n15.7\n16.1/x+x\n17.0\n18 . Constant \n19.0 \n20. -3,-2\nSection B \n	\N	2025-05-25 15:37:26.565942
1109	89	 Section A \n1. Non terminating and repeating\n2.3/4\n3.always rational\n4.0\n5.4\n6.3\n7.a\n8.3\n9.x+1\n10.(x,y)\n11.quadrant 2\n12.origin\n13.0\n14.-5\n15.7\n16.1/x+x\n17.0\n18 . Constant \n19.0 \n20. -3,-2\nSection B \n21.\n	\N	2025-05-25 15:38:07.913998
1110	89	 Section A \n1. Non terminating and repeating\n2.3/4\n3.always rational\n4.0\n5.4\n6.3\n7.a\n8.3\n9.x+1\n10.(x,y)\n11.quadrant 2\n12.origin\n13.0\n14.-5\n15.7\n16.1/x+x\n17.0\n18 . Constant \n19.0 \n20. -3,-2\nSection B \n21.w\n	\N	2025-05-25 15:38:48.123668
1111	89	 Section A \n1. Non terminating and repeating\n2.3/4\n3.always rational\n4.0\n5.4\n6.3\n7.a\n8.3\n9.x+1\n10.(x,y)\n11.quadrant 2\n12.origin\n13.0\n14.-5\n15.7\n16.1/x+x\n17.0\n18 . Constant \n19.0 \n20. -3,-2\nSection B \n21. A is f\n	\N	2025-05-25 15:38:56.328327
1112	89	 Section A \n1. Non terminating and repeating\n2.3/4\n3.always rational\n4.0\n5.4\n6.3\n7.a\n8.3\n9.x+1\n10.(x,y)\n11.quadrant 2\n12.origin\n13.0\n14.-5\n15.7\n16.1/x+x\n17.0\n18 . Constant \n19.0 \n20. -3,-2\nSection B \n21. A is false ,but R is true\n22.\n	\N	2025-05-25 15:39:23.7759
1113	89	 Section A \n1. Non terminating and repeating\n2.3/4\n3.always rational\n4.0\n5.4\n6.3\n7.a\n8.3\n9.x+1\n10.(x,y)\n11.quadrant 2\n12.origin\n13.0\n14.-5\n15.7\n16.1/x+x\n17.0\n18 . Constant \n19.0 \n20. -3,-2\nSection B \n21. A is false ,but R is true\n22.A is true ,but R is false\n23.\n	\N	2025-05-25 15:41:50.039288
847	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12.	\N	2025-05-18 07:32:52.580576
848	49	the following are the functions of the plasma membrane the plasma membrane is called the selectivali vermiable membrane as it allows only the selective materials to come inside and go outside from the membrane it protects the cell from the harmful substances to come inside the cell it do not allow the important interior substances to go move outside the cell it is also called the protective layer of the cell .\n2) \nbetween a Plant cell and Animal cell difference	\N	2025-05-18 07:33:00.06338
849	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \n\n	\N	2025-05-18 07:33:03.476561
1114	89	 Section A \n1. Non terminating and repeating\n2.3/4\n3.always rational\n4.0\n5.4\n6.3\n7.a\n8.3\n9.x+1\n10.(x,y)\n11.quadrant 2\n12.origin\n13.0\n14.-5\n15.7\n16.1/x+x\n17.0\n18 . Constant \n19.0 \n20. -3,-2\nSection B \n21. A is false ,but R is true\n22.A is true ,but R is false\n23.A is \n	\N	2025-05-25 15:42:27.252632
851	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has crom\n	\N	2025-05-18 07:33:27.83617
852	49	the following are the functions of the plasma membrane the plasma membrane is called the selectivali vermiable membrane as it allows only the selective materials to come inside and go outside from the membrane it protects the cell from the harmful substances to come inside the cell it do not allow the important interior substances to go move outside the cell it is also called the protective layer of the cell \n\n2) the difference between a Plant cell and Animal cell\n	\N	2025-05-18 07:33:30.641403
1115	89	 Section A \n1. Non terminating and repeating\n2.3/4\n3.always rational\n4.0\n5.4\n6.3\n7.a\n8.3\n9.x+1\n10.(x,y)\n11.quadrant 2\n12.origin\n13.0\n14.-5\n15.7\n16.1/x+x\n17.0\n18 . Constant \n19.0 \n20. -3,-2\nSection B \n21. A is false ,but R is true\n22.A is true ,but R is false\n23.\n24. \n	\N	2025-05-25 15:42:45.087735
854	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. 	\N	2025-05-18 07:33:52.707016
1116	89	 Section A \n1. Non terminating and repeating\n2.3/4\n3.always rational\n4.0\n5.4\n6.3\n7.a\n8.3\n9.x+1\n10.(x,y)\n11.quadrant 2\n12.origin\n13.0\n14.-5\n15.7\n16.1/x+x\n17.0\n18 . Constant \n19.0 \n20. -3,-2\nSection B \n21. A is false ,but R is true\n22.A is true ,but R is false\n23.\n24. A is true ,but\n	\N	2025-05-25 15:42:56.361247
1117	89	 Section A \n1. Non terminating and repeating\n2.3/4\n3.always rational\n4.0\n5.4\n6.3\n7.a\n8.3\n9.x+1\n10.(x,y)\n11.quadrant 2\n12.origin\n13.0\n14.-5\n15.7\n16.1/x+x\n17.0\n18 . Constant \n19.0 \n20. -3,-2\nSection B \n21. A is false ,but R is true\n22.A is true ,but R is false\n23.\n24. A is false ,but R is true\n25.\n	\N	2025-05-25 15:43:25.257759
1118	89	 Section A \n1. Non terminating and repeating\n2.3/4\n3.always rational\n4.0\n5.4\n6.3\n7.a\n8.3\n9.x+1\n10.(x,y)\n11.quadrant 2\n12.origin\n13.0\n14.-5\n15.7\n16.1/x+x\n17.0\n18 . Constant \n19.0 \n20. -3,-2\nSection B \n21. A is false ,but R is true\n22.A is true ,but R is false\n23.\n24. A is false ,but R is true\n25. Ais false ,but R is true\n\n	\N	2025-05-25 15:44:22.897189
1119	89	 Section A \n1. Non terminating and repeating\n2.3/4\n3.always rational\n4.0\n5.4\n6.3\n7.a\n8.3\n9.x+1\n10.(x,y)\n11.quadrant 2\n12.origin\n13.0\n14.-5\n15.7\n16.1/x+x\n17.0\n18 . Constant \n19.0 \n20. -3,-2\nSection B \n21. A is false ,but R is true\n22.A is true ,but R is false\n23.A is true ,b\n24. A is false ,but R is true\n25. Ais false ,but R is true\n\n	\N	2025-05-25 15:46:26.57983
1120	89	 Section A \n1. Non terminating and repeating\n2.3/4\n3.always rational\n4.0\n5.4\n6.3\n7.a\n8.3\n9.x+1\n10.(x,y)\n11.quadrant 2\n12.origin\n13.0\n14.-5\n15.7\n16.1/x+x\n17.0\n18 . Constant \n19.0 \n20. -3,-2\nSection B \n21. A is false ,but R is true\n22.A is true ,but R is false\n23.A is true ,but R is false\n24. A is false ,but R is true\n25. Ais false ,but R is true\n\n	\N	2025-05-25 15:46:48.052518
1121	89	 Section A \r\n1. Non terminating and repeating\r\n2.3/4\r\n3.always rational\r\n4.0\r\n5.4\r\n6.3\r\n7.a\r\n8.3\r\n9.x+1\r\n10.(x,y)\r\n11.quadrant 2\r\n12.origin\r\n13.0\r\n14.-5\r\n15.7\r\n16.1/x+x\r\n17.0\r\n18 . Constant \r\n19.0 \r\n20. -3,-2\r\nSection B \r\n21. A is false ,but R is true\r\n22.A is true ,but R is false\r\n23.A is true ,but R is false\r\n24. A is false ,but R is true\r\n25. Ais false ,but R is true\r\n\r\n	\N	2025-05-25 15:46:58.998053
1124	94	26. 	\N	2025-05-25 15:50:56.092522
1125	94	26. √3\n27.	\N	2025-05-25 15:51:13.896462
855	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolas\n	\N	2025-05-18 07:33:57.998081
858	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \n	\N	2025-05-18 07:34:28.514743
1123	102	under root 2 is an irrational number under root 3 is an irrational why they are irrational number because irrational number is defined as a number which can be written in the form of p by q where p and q are positive integers and q is not	\N	2025-05-25 21:17:22.24455
860	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A i	\N	2025-05-18 07:34:53.204674
861	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt	\N	2025-05-18 07:34:57.859171
862	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is al	\N	2025-05-18 07:35:22.673091
863	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA	\N	2025-05-18 07:35:27.837306
864	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.	\N	2025-05-18 07:35:53.222415
865	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which helps in the production of protein	\N	2025-05-18 07:35:57.818504
866	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n1	\N	2025-05-18 07:36:22.621467
867	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which of protein which help in protein synthesis	\N	2025-05-18 07:36:27.838811
868	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R id	\N	2025-05-18 07:36:53.167419
869	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which help in protein synthesis.	\N	2025-05-18 07:36:59.529152
1126	94	26. √3\n27. \n28.\n29. Irra	\N	2025-05-25 15:52:26.319966
1127	94	26. √3\n27. \n28.\n29. Irrational 	\N	2025-05-25 15:52:31.98524
1128	94	26. √3\n27. \n28.\n29. Irrational \n	\N	2025-05-25 15:53:52.993675
1129	94	SectionA26. √3\n27. \n28.\n29. Irrational \n	\N	2025-05-25 15:53:55.940756
1130	94	Section a \n26. √3\n27. \n28.\n29. Irrational \n	\N	2025-05-25 15:54:02.414699
1131	94	Section a \n26. √3\n27. \n28.\n29. Irrational \nSectonB\n\n	\N	2025-05-25 15:54:25.93432
1132	94	Section a \n26. √3\n27. \n28.\n29. Irrational \nSectonB\n30\n	\N	2025-05-25 15:54:36.596475
1133	94	Case study 1\n26. √3\n27. \n28.\n29. Irrational \nSectonB\n30\n	\N	2025-05-25 15:54:55.936654
871	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n16.	\N	2025-05-18 07:37:22.643765
872	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which help in protein synthesis. the process by which water moves through higher concentration to lower concentration is called osmosis	\N	2025-05-18 07:37:28.479381
1134	94	Case study 1\n26. √3\n27. \n28.\n29. Irrational\nCase study 2\n30.\n	\N	2025-05-25 15:55:21.07837
1135	94	Case study 1\n26. √3\n27. \n28.\n29. Irrational\nCase study 2\n30. Triangle \n31.\n	\N	2025-05-25 15:58:26.285716
1017	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n17. The outermost covering of cell is called plasma membrane \n It is also known as  selectively permeable membrane \nfunction= it allows some substance to enter or exit \n16. Prokaryotic cell= 1. it have no nucleus\n                      2. It is present in  small organisms like bacteria,fungi etc\nEukaryotic cell=1. It have nucleus \n                2. It is present in organism like animal,plants etc\n18. Plant cell= 1. It covered by  cell wall \n                2. It  have mitochondria \nAnimal cell = 1.it covered by plasma membrane \n              2. It doesn't not have mitochondria\n22. It have to type of  endoplasmic reticulum \n1. Rough endoplasmic reticulum \n2.smooth endoplasmic reticulum \n19.it contain the cell's hereditary information and control of cell 's growth and reproduction \n21.plastid are double membrane organelles which found in the cell plant and yeast	\N	2025-05-18 08:16:34.40307
875	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which help in protein synthesis.\n20	\N	2025-05-18 07:38:33.436979
910	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n17. The outermost covering of cell is called plasma membrane \n It is also known as  selectively permeable membrane \nfunction= it allows some substance to enter exit	\N	2025-05-18 07:48:22.752924
1136	88	1 c non terminathing repeating 	\N	2025-05-25 15:58:46.052407
1137	88	1 c non terminating repeating \n2	\N	2025-05-25 15:58:49.763646
1138	94	Case study 1\n26. √3\n27. \n28.\n29. Irrational\nCase study 2\n31. Triangle \n32.\n	\N	2025-05-25 15:58:52.035226
1139	94	Case study 1\n26. √3\n27. \n28.\n29. Irrational\n30\nCase study 2\n31. Triangle \n32.\n	\N	2025-05-25 15:58:55.964071
1140	94	Case study 1\n26. √3\n27. \n28.\n29. Irrational\n30.\nCase study 2\n31. Triangle \n32.\n	\N	2025-05-25 15:59:01.268872
876	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which help in protein synthesis.\n20 the spontaneous movement of water in the cell through the region of higher concentration to the region of lower concentration is called osmosis	\N	2025-05-18 07:38:58.379571
1141	88	1 c non terminating repeating \n2 c 3 /4\n3c sometimes rational \n4b 1 \n	\N	2025-05-25 15:59:20.458117
878	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which help in protein synthesis.\n20 the spontaneous movement of water in the cell through the region of higher concentration to the region of lower concentration is called osmosis ex 	\N	2025-05-18 07:39:27.943889
1142	94	Case study 1\n26. √3\n27. \n28.\n29. Irrational\n30.\nCase study 2\n31. Triangle \n32.40 unit\n33.\n	\N	2025-05-25 15:59:25.933528
1143	88	1 c non terminating repeating \n2 c 3 /4\n3c sometimes rational \n4b 1 \n5 d 4 	\N	2025-05-25 15:59:30.138893
1144	88	1 c non terminating repeating \n2 c 3 /4\n3c sometimes rational \n4b 1 \n5 d 4 \n6 	\N	2025-05-25 15:59:41.886729
1145	88	1 c non terminating repeating \n2 c 3 /4\n3c sometimes rational \n4b 1 \n5 d 4 \n6 c 3 \n	\N	2025-05-25 15:59:49.79473
1146	94	Case study 1\n26. √3\n27. \n28.\n29. Irrational\n30.\nCase study 2\n31. Triangle \n32.40 unit\n33.quadrant 2\n34.\n	\N	2025-05-25 15:59:56.242204
1147	88	1 c non terminating repeating \n2 c 3 /4\n3c sometimes rational \n4b 1 \n5 d 4 \n6 c 3 \n7	\N	2025-05-25 15:59:57.019177
1148	88	1 c non terminating repeating \n2 c 3 /4\n3c sometimes rational \n4b 1 \n5 d 4 \n6 c 3 \n7 b ax +b\n	\N	2025-05-25 16:00:19.862532
1149	94	Case study 1\n26. √3\n27. \n28.\n29. Irrational\n30.\nCase study 2\n31. Triangle \n32.40 unit\n33.quadrant 2\n34.60,0)\n	\N	2025-05-25 16:00:26.16218
1150	88	1 c non terminating repeating \n2 c 3 /4\n3c sometimes rational \n4b 1 \n5 d 4 \n6 c 3 \n7 b) ax +b\n	\N	2025-05-25 16:00:26.563043
1151	94	Case study 1\n26. √3\n27. \n28.\n29. Irrational\n30.\nCase study 2\n31. Triangle \n32.40 unit\n33.quadrant 2\n34(.60,0)\n	\N	2025-05-25 16:00:31.65751
1152	88	1 c non terminating repeating \n2 c 3 /4\n3 c sometimes rational \n4 b) 1 \n5 d) 4 \n6 c) 3 \n7 b) ax +b\n	\N	2025-05-25 16:00:49.647682
1153	94	Case study 1\n26. √3\n27. \n28.\n29. Irrational\n30.\nCase study 2\n31. Triangle \n32.40 unit\n33.quadrant 2\n34(.60,0)\n35.\n	\N	2025-05-25 16:00:55.888892
1154	94	Case study 1\n26. √3\n27. \n28.\n29. Irrational\n30.\nCase study 2\n31. Triangle \n32.40 unit\n33.quadrant 2\n34(.60,0)\n35.0\n	\N	2025-05-25 16:01:07.396985
1155	88	1 c\n1 c) non terminating repeating \n2 c) 3 /4\n3 c) sometimes rational \n4 b) 1 \n5 d) 4 \n6 c) 3 \n7 b) ax +b\n	\N	2025-05-25 16:01:12.674551
1156	88	1 c\n1 c) non terminating repeating \n2 c) 3 /4\n3 c) sometimes rational \n4 b) 1 \n5 d) 4 \n6 c) 3 \n7 b) ax +b\n8 c\n	\N	2025-05-25 16:01:20.324621
1157	88	1 c\n1 c) non terminating repeating \n2 c) 3 /4\n3 c) sometimes rational \n4 b) 1 \n5 d) 4 \n6 c) 3 \n7 b) ax +b\n8 c) b\n	\N	2025-05-25 16:01:26.257143
1158	88	1 c\n1 c) non terminating repeating \n2 c) 3 /4\n3 c) sometimes rational \n4 b) 1 \n5 d) 4 \n6 c) 3 \n7 b) ax +b\n8 c) 4\n	\N	2025-05-25 16:01:34.631571
1159	88	1 c\n1 c) non terminating repeating \n2 c) 3 /4\n3 c) sometimes rational \n4 b) 1 \n5 d) 4 \n6 c) 3 \n7 b) ax +b\n8 c) 4\n\n	\N	2025-05-25 16:01:41.585999
1160	94	Case study 1\n26. √3\n27. \n28.\n29. Irrational\n30.√3\nCase study 2\n31. Triangle \n32.40 unit\n33.quadrant 2\n34(.60,0)\n35.0\n	\N	2025-05-25 16:01:46.836058
1161	88	1 c\n1 c) non terminating repeating \n2 c) 3 /4\n3 c) sometimes rational \n4 b) 1 \n5 d) 4 \n6 c) 3 \n7 b) ax +b\n8 c) 4\n9 \n10 \n	\N	2025-05-25 16:01:49.777559
1162	88	1 c\n1 c) non terminating repeating \n2 c) 3 /4\n3 c) sometimes rational \n4 b) 1 \n5 d) 4 \n6 c) 3 \n7 b) ax +b\n8 c) 4\n9 \n10 a) ( 0,y)\n\n	\N	2025-05-25 16:02:21.938092
1163	88	1 c\n1 c) non terminating repeating \n2 c) 3 /4\n3 c) sometimes rational \n4 b) 1 \n5 d) 4 \n6 c) 3 \n7 b) ax +b\n8 c) 4\n9 \n10 a) ( 0,y)\n11 b) quadrant 2\n12 \n	\N	2025-05-25 16:02:50.382293
1164	88	1 c\n1 c) non terminating repeating \n2 c) 3 /4\n3 c) sometimes rational \n4 b) 1 \n5 d) 4 \n6 c) 3 \n7 b) ax +b\n8 c) 4\n9 \n10 a) ( 0,y)\n11 b) quadrant 2\n12 c ) origin \n13 ) cannat be determined \n	\N	2025-05-25 16:03:44.455132
1165	88	1 c\n1 c) non terminating repeating \n2 c) 3 /4\n3 c) sometimes rational \n4 b) 1 \n5 d) 4 \n6 c) 3 \n7 b) ax +b\n8 c) 4\n9 \n10 a) ( 0,y)\n11 b) quadrant 2\n12 c ) origin \n13 ) cannot be determined \n\n	\N	2025-05-25 16:04:50.407002
1166	94	Case study 1\r\n26. √3\r\n27. \r\n28.\r\n29. Irrational\r\n30.√3\r\nCase study 2\r\n31. Triangle \r\n32.40 unit\r\n33.quadrant 2\r\n34(.60,0)\r\n35.0\r\n\n\n[Note: This test was submitted after the time limit expired. The submission time has been recorded as the expiration time.]	\N	2025-05-25 16:05:06.824668
1167	88	1 c\n1 c) non terminating repeating \n2 c) 3 /4\n3 c) sometimes rational \n4 b) 1 \n5 d) 4 \n6 c) 3 \n7 b) ax +b\n8 c) 4\n9 \n10 a) ( 0,y)\n11 b) quadrant 2\n12 c ) origin \n13 ) cannot be determined \n14 a) -5\n15 b)  7\n	\N	2025-05-25 16:05:37.897881
1168	88	1 c\n1 c) non terminating repeating \n2 c) 3 /4\n3 c) sometimes rational \n4 b) 1 \n5 d) 4 \n6 c) 3 \n7 b) ax +b\n8 c) 4\n9 \n10 a) ( 0,y)\n11 b) quadrant 2\n12 c ) origin \n13 ) cannot be determined \n14 a) -5\n15 b)  7\n\n	\N	2025-05-25 16:05:42.055154
882	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which help in protein synthesis.\n20 the spontaneous movement ofater in the cell through the region of higher concentration to the region of lower concentration is called osmosis ex 	\N	2025-05-18 07:42:20.434124
883	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which help in protein synthesis.\n20 the spontaneous movement of water in the cell through the region of higher concentration to the region of lower concentration is called osmosis ex absorption of water by rr	\N	2025-05-18 07:42:49.900205
884	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of 	\N	2025-05-18 07:42:52.662627
1169	88	1 c\n1 c) non terminating repeating \n2 c) 3 /4\n3 c) sometimes rational \n4 b) 1 \n5 d) 4 \n6 c) 3 \n7 b) ax +b\n8 c) 4\n9 \n10 a) ( 0,y)\n11 b) quadrant 2\n12 c ) origin \n13 ) cannot be determined \n14 a) -5\n15 b)  7\n16 d ) 5x \n17\n	\N	2025-05-25 16:15:22.598982
911	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which help in protein synthesis.\n20 the spontaneous movement of water in the cell through the region of higher concentration to the region of lower concentration is called osmosis ex absorption of water by roots \n21 plastids are only present in plants which store starch ,oils etc\n22 endoplasmic reticulum is also known as ER which form network membrane bound tubes and sheets within cell . There are two types of ER \n•rough endoplasmic reticulum RER \n• smooth endoplasmic reticulum SER \nRER is right because it have ribosomes which help in protein synthesis \n	\N	2025-05-18 07:48:50.611728
1170	88	1 c\n1 c) non terminating repeating \n2 c) 3 /4\n3 c) sometimes rational \n4 b) 1 \n5 d) 4 \n6 c) 3 \n7 b) ax +b\n8 c) 4\n9 \n10 a) ( 0,y)\n11 b) quadrant 2\n12 c ) origin \n13 ) cannot be determined \n14 a) -5\n15 b)  7\n16 d ) 5x \n17 \n	\N	2025-05-25 16:15:25.366453
1171	88	1 c\n1 c) non terminating repeating \n2 c) 3 /4\n3 c) sometimes rational \n4 b) 1 \n5 d) 4 \n6 c) 3 \n7 b) ax +b\n8 c) 4\n9 \n10 a) ( 0,y)\n11 b) quadrant 2\n12 c ) origin \n13 ) cannot be determined \n14 a) -5\n15 b)  7\n16 d ) 5x \n17 d 3\n	\N	2025-05-25 16:15:32.784495
1172	88	1 c\n1 c) non terminating repeating \n2 c) 3 /4\n3 c) sometimes rational \n4 b) 1 \n5 d) 4 \n6 c) 3 \n7 b) ax +b\n8 c) 4\n9 \n10 a) ( 0,y)\n11 b) quadrant 2\n12 c ) origin \n13 ) cannot be determined \n14 a) -5\n15 b)  7\n16 d ) 5x \n17 d 3\n18 a\n	\N	2025-05-25 16:15:49.791408
1173	88	1 c\n1 c) non terminating repeating \n2 c) 3 /4\n3 c) sometimes rational \n4 b) 1 \n5 d) 4 \n6 c) 3 \n7 b) ax +b\n8 c) 4\n9 \n10 a) ( 0,y)\n11 b) quadrant 2\n12 c ) origin \n13 ) cannot be determined \n14 a) -5\n15 b)  7\n16 d ) 5x \n17 d 3\n18 a) monomial \n19 a)\n	\N	2025-05-25 16:16:19.907773
1174	88	1 c\n1 c) non terminating repeating \n2 c) 3 /4\n3 c) sometimes rational \n4 b) 1 \n5 d) 4 \n6 c) 3 \n7 b) ax +b\n8 c) 4\n9 \n10 a) ( 0,y)\n11 b) quadrant 2\n12 c ) origin \n13 ) cannot be determined \n14 a) -5\n15 b)  7\n16 d ) 5x \n17 d 3\n18 a) monomial \n19 a) 0 \n20 b ) - 3-2\n	\N	2025-05-25 16:16:56.901416
1175	88	1 c\n1 c) non terminating repeating \n2 c) 3 /4\n3 c) sometimes rational \n4 b) 1 \n5 d) 4 \n6 c) 3 \n7 b) ax +b\n8 c) 4\n9 \n10 a) ( 0,y)\n11 b) quadrant 2\n12 c ) origin \n13 ) cannot be determined \n14 a) -5\n15 b)  7\n16 d ) 5x \n17 d 3\n18 a) monomial \n19 a) 0 \n20 b ) - 3-2 \n21 a \n	\N	2025-05-25 16:17:00.317554
1176	88	1 c\n1 c) non terminating repeating \n2 c) 3 /4\n3 c) sometimes rational \n4 b) 1 \n5 d) 4 \n6 c) 3 \n7 b) ax +b\n8 c) 4\n9 \n10 a) ( 0,y)\n11 b) quadrant 2\n12 c ) origin \n13 ) cannot be determined \n14 a) -5\n15 b)  7\n16 d ) 5x \n17 d 3\n18 a) monomial \n19 a) 0 \n20 b ) - 3-2 \n21 a \n\n\n\n\n\n\n\n0\n	\N	2025-05-25 16:17:10.893328
1177	88	1 c\n1 c) non terminating repeating \n2 c) 3 /4\n3 c) sometimes rational \n4 b) 1 \n5 d) 4 \n6 c) 3 \n7 b) ax +b\n8 c) 4\n9 \n10 a) ( 0,y)\n11 b) quadrant 2\n12 c ) origin \n13 ) cannot be determined \n14 a) -5\n15 b)  7\n16 d ) 5x \n17 d 3\n18 a) monomial \n19 a) 0 \n20 b ) - 3-2 \n21 a \n\n\n\n\n\n\n	\N	2025-05-25 16:17:19.825834
886	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which help in protein synthesis.\n20 the spontaneous movement of water in the cell through the region of higher concentration to the region of lower concentration is called osmosis ex absorption of water by roots 	\N	2025-05-18 07:43:20.513148
887	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of of cell 	\N	2025-05-18 07:43:23.131515
1178	88	1 c\n1 c) non terminating repeating \n2 c) 3 /4\n3 c) sometimes rational \n4 b) 1 \n5 d) 4 \n6 c) 3 \n7 b) ax +b\n8 c) 4\n9 \n10 a) ( 0,y)\n11 b) quadrant 2\n12 c ) origin \n13 ) cannot be determined \n14 a) -5\n15 b)  7\n16 d ) 5x \n17 d 3\n18 a) monomial \n19 a) 0 \n20 b ) - 3-2 \n21 a )\n	\N	2025-05-25 16:17:34.040316
889	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which help in protein synthesis.\n20 the spontaneous movement of water in the cell through the region of higher concentration to the region of lower concentration is called osmosis ex absorption of water by roots \n21 plas	\N	2025-05-18 07:43:49.899335
890	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from  higher	\N	2025-05-18 07:43:52.634388
1179	88	1 c\n1 c) non terminating repeating \n2 c) 3 /4\n3 c) sometimes rational \n4 b) 1 \n5 d) 4 \n6 c) 3 \n7 b) ax +b\n8 c) 4\n9 \n10 a) ( 0,y)\n11 b) quadrant 2\n12 c ) origin \n13 ) cannot be determined \n14 a) -5\n15 b)  7\n16 d ) 5x \n17 d 3\n18 a) monomial \n19 a) 0 \n20 b ) - 3-2 \n21 a )\n22 b) \n\n	\N	2025-05-25 16:17:49.829573
1180	88	1 c\n1 c) non terminating repeating \n2 c) 3 /4\n3 c) sometimes rational \n4 b) 1 \n5 d) 4 \n6 c) 3 \n7 b) ax +b\n8 c) 4\n9 \n10 a) ( 0,y)\n11 b) quadrant 2\n12 c ) origin \n13 ) cannot be determined \n14 a) -5\n15 b)  7\n16 d ) 5x \n17 d 3\n18 a) monomial \n19 a) 0 \n20 b ) - 3-2 \n21 a )\n22 b) \n23 a)\n24 d)\n25 a\n	\N	2025-05-25 16:18:23.673839
1181	88	1 c\n1 c) non terminating repeating \n2 c) 3 /4\n3 c) sometimes rational \n4 b) 1 \n5 d) 4 \n6 c) 3 \n7 b) ax +b\n8 c) 4\n9 \n10 a) ( 0,y)\n11 b) quadrant 2\n12 c ) origin \n13 ) cannot be determined \n14 a) -5\n15 b)  7\n16 d ) 5x \n17 d 3\n18 a) monomial \n19 a) 0 \n20 b ) - 3-2 \n21 a )\n22 b) \n23 a)\n24 d)\n25 a)\n	\N	2025-05-25 16:18:30.824953
1182	88	1 c\n1 c) non terminating repeating \n2 c) 3 /4\n3 c) sometimes rational \n4 b) 1 \n5 d) 4 \n6 c) 3 \n7 b) ax +b\n8 c) 4\n9 a ) \n10 a) ( 0,y)\n11 b) quadrant 2\n12 c ) origin \n13 ) cannot be determined \n14 a) -5\n15 b)  7\n16 d ) 5x \n17 d 3\n18 a) monomial \n19 a) 0 \n20 b ) - 3-2 \n21 a )\n22 b) \n23 a)\n24 d)\n25 a)\n	\N	2025-05-25 16:19:14.015962
1183	88	1 c\n1 c) non terminating repeating \n2 c) 3 /4\n3 c) sometimes rational \n4 b) 1 \n5 d) 4 \n6 c) 3 \n7 b) ax +b\n8 c) 4\n9 a ) x+1\n10 a) ( 0,y)\n11 b) quadrant 2\n12 c ) origin \n13 ) cannot be determined \n14 a) -5\n15 b)  7\n16 d ) 5x \n17 d 3\n18 a) monomial \n19 a) 0 \n20 b ) - 3-2 \n21 a )\n22 b) \n23 a)\n24 d)\n25 a)\n	\N	2025-05-25 16:19:19.904751
1184	88	\n1 c) non terminating repeating \n2 c) 3 /4\n3 c) sometimes rational \n4 b) 1 \n5 d) 4 \n6 c) 3 \n7 b) ax +b\n8 c) 4\n9 a ) x+1\n10 a) ( 0,y)\n11 b) quadrant 2\n12 c ) origin \n13 ) cannot be determined \n14 a) -5\n15 b)  7\n16 d ) 5x \n17 d 3\n18 a) monomial \n19 a) 0 \n20 b ) - 3-2 \n21 a )\n22 b) \n23 a)\n24 d)\n25 a)\n	\N	2025-05-25 16:19:33.606831
1185	93	26	\N	2025-05-25 16:41:36.06765
1186	93	26 b ) 	\N	2025-05-25 16:41:43.16331
1187	93	26 b ) √	\N	2025-05-25 16:43:48.422234
1188	93	26 b ) √2 \n27	\N	2025-05-25 16:43:59.818733
1189	93	26 b ) √2 \n27 a) 	\N	2025-05-25 16:44:15.490316
1190	93	26 b ) √2 \n27 a) √ 3 \n28 a ) 1 and 	\N	2025-05-25 16:44:33.262965
1191	93	26 b ) √2 \n27 a) √ 3 \n28 a ) 1 and 2 \n29b ) irrational \n30 c ) 	\N	2025-05-25 16:45:03.406619
1192	93	26 b ) √2 \n27 a) √ 3 \n28 a ) 1 and 2 \n29b ) irrational \n30 c ) √ 5 \n31 b ) rectangle \n3	\N	2025-05-25 16:45:34.479482
1193	93	26 b ) √2 \n27 a) √ 3 \n28 a ) 1 and 2 \n29b ) irrational \n30 c ) √ 5 \n31 b ) rectangle \n32 40 units 	\N	2025-05-25 16:45:46.771475
1194	93	26 b ) √2 \n27 a) √ 3 \n28 a ) 1 and 2 \n29b ) irrational \n30 c ) √ 5 \n31 b ) rectangle \n32 40 units \n33 quadrant 3 \n34	\N	2025-05-25 16:46:03.255144
1195	93	26 b ) √2 \n27 a) √ 3 \n28 a ) 1 and 2 \n29b ) irrational \n30 c ) √ 5 \n31 b ) rectangle \n32 40 units \n33 quadrant 3 \n34 c ) 60,0 \n35 	\N	2025-05-25 16:46:33.286572
892	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which help in protein synthesis.\n20 the spontaneous movement of water in the cell through the region of higher concentration to the region of lower concentration is called osmosis ex absorption of water by roots \n21 plastids are only present in plants which store starch ,oils,	\N	2025-05-18 07:44:20.464351
893	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration 	\N	2025-05-18 07:44:22.636444
1196	93	26 b ) √2 \n27 a) √ 3 \n28 a ) 1 and 2 \n29b ) irrational \n30 c ) √ 5 \n31 b ) rectangle \n32 40 units \n33 quadrant 3 \n34 c ) 60,0 \n35 b ) 0 	\N	2025-05-25 16:46:57.920792
895	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which help in protein synthesis.\n20 the spontaneous movement of water in the cell through the region of higher concentration to the region of lower concentration is called osmosis ex absorption of water by roots \n21 plastids are only present in plants which store starch ,oils etc\n22 	\N	2025-05-18 07:44:49.885983
896	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmo	\N	2025-05-18 07:44:53.443207
1197	93	26 b ) √2 \r\n27 a) √ 3 \r\n28 a ) 1 and 2 \r\n29b ) irrational \r\n30 c ) √ 5 \r\n31 b ) rectangle \r\n32 40 units \r\n33 quadrant 3 \r\n34 c ) 60,0 \r\n35 b ) 0 	\N	2025-05-25 16:47:03.451877
1198	88	1 c) non terminating repeating \r\n2 c) 3 /4\r\n3 c) sometimes rational \r\n4 b) 1 \r\n5 d) 4 \r\n6 c) 3 \r\n7 b) ax +b\r\n8 c) 4\r\n9 a ) x+1\r\n10 a) ( 0,y)\r\n11 b) quadrant 2\r\n12 c ) origin \r\n13 ) cannot be determined \r\n14 a) -5\r\n15 b)  7\r\n16 d ) 5x \r\n17 d 3\r\n18 a) monomial \r\n19 a) 0 \r\n20 b ) - 3-2 \r\n21 a )\r\n22 b) \r\n23 a)\r\n24 d)\r\n25 a)\r\n	\N	2025-05-25 16:47:43.446934
1199	90	hi there is testing School the might seem to be working fine and the smelting it so that you can connect the sample and eventually submit the text	\N	2025-05-26 03:35:33.654505
1200	90	hi there is testing School the might seem to be working fine and the smelting it so that you can connect the sample and eventually submit the text	\N	2025-05-26 03:35:43.694887
898	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which help in protein synthesis.\n20 the spontaneous movement of water in the cell through the region of higher concentration to the region of lower concentration is called osmosis ex absorption of water by roots \n21 plastids are only present in plants which store starch ,oils etc\n22 endoplasmic reticulum is also known as ER	\N	2025-05-18 07:45:19.97015
899	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n1	\N	2025-05-18 07:45:22.877874
901	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which help in protein synthesis.\n20 the spontaneous movement of water in the cell through the region of higher concentration to the region of lower concentration is called osmosis ex absorption of water by roots \n21 plastids are only present in plants which store starch ,oils etc\n22 endoplasmic reticulum is also known as ERw	\N	2025-05-18 07:45:50.45046
902	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n17. The o	\N	2025-05-18 07:45:52.78185
903	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n17. The outermost covering of cell is called plasma membee	\N	2025-05-18 07:46:23.160135
912	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n17. The outermost covering of cell is called plasma membrane \n It is also known as  selectively permeable membrane \nfunction= it allows some substance to enter or exit \n	\N	2025-05-18 07:48:52.637972
904	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which help in protein synthesis.\n20 the spontaneous movement of water in the cell through the region of higher concentration to the region of lower concentration is called osmosis ex absorption of water by roots \n21 plastids are only present in plants which store starch ,oils etc\n22 endoplasmic reticulum is also known as ER which form network membrane bound tubes and shee	\N	2025-05-18 07:46:50.550486
905	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n17. The outermost covering of cell is called plasma membrane \n It is also known as se	\N	2025-05-18 07:46:52.615904
906	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which help in protein synthesis.\n20 the spontaneous movement of water in the cell through the region of higher concentration to the region of lower concentration is called osmosis ex absorption of water by roots \n21 plastids are only present in plants which store starch ,oils etc\n22 endoplasmic reticulum is also known as ER which form network membrane bound tubes and sheets within cell . There are two types of E	\N	2025-05-18 07:47:19.898432
907	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n17. The outermost covering of cell is called plasma membrane \n It is also known as  selectively permeable membrane \nfunction	\N	2025-05-18 07:47:22.6881
908	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which help in protein synthesis.\n20 the spontaneous movement of water in the cell through the region of higher concentration to the region of lower concentration is called osmosis ex absorption of water by roots \n21 plastids are only present in plants which store starch ,oils etc\n22 endoplasmic reticulum is also known as ER which form network membrane bound tubes and sheets within cell . There are two types of ER \n•rough endoplasmic reticulum \n• smooth endoplasmic reticulum 	\N	2025-05-18 07:47:50.452073
909	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n17. The outermost covering of cell is called plasma membrane \n It is also known as  selectively permeable membrane \nfunction= it allows some substa	\N	2025-05-18 07:47:52.573026
913	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which help in protein synthesis.\n20 the spontaneous movement of water in the cell through the region of higher concentration to the region of lower concentration is called osmosis ex absorption of water by roots \n21 plastids are only present in plants which store starch ,oils etc\n22 endoplasmic reticulum is also known as ER which form network membrane bound tubes and sheets within cell . There are two types of ER \n•rough endoplasmic reticulum RER \n• smooth endoplasmic reticulum SER \nRER is rough  because it have ribosomes which help in protein synthesis \nSER is smooth because they \n	\N	2025-05-18 07:49:19.894497
915	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which help in protein synthesis.\n20 the spontaneous movement of water in the cell through the region of higher concentration to the region of lower concentration is called osmosis ex absorption of water by roots \n21 plastids are only present in plants which store starch ,oils etc\n22 endoplasmic reticulum is also known as ER which form network membrane bound tubes and sheets within cell . There are two types of ER \n•rough endoplasmic reticulum RER \n• smooth endoplasmic reticulum SER \nRER is rough  because it have ribosomes which help in protein synthesis \nSER is smooth because they don't have these ribosomes present in them \n	\N	2025-05-18 07:49:50.044561
917	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which help in protein synthesis.\n20 the spontaneous movement of water in the cell through the region of higher concentration to the region of lower concentration is called osmosis ex absorption of water by roots \n21 plastids are only present in plants which store starch ,oils etc\n22 endoplasmic reticulum is also known as ER which form network membrane bound tubes and sheets within cell . There are two types of ER \n•rough endoplasmic reticulum RER \n• smooth endoplasmic reticulum SER \nRER is rough  because it have ribosomes which help in protein synthesis \nSER is smooth because they don't have these ribosomes present in them\n \n	\N	2025-05-18 07:50:20.033513
918	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n17. The outermost covering of cell is called plasma membrane \n It is also known as  selectively permeable membrane \nfunction= it allows some substance to enter or exit \n16.	\N	2025-05-18 07:50:23.587086
923	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n17. The outermost covering of cell is called plasma membrane \n It is also known as  selectively permeable membrane \nfunction= it allows some substance to enter or exit \n16. Prokaryotic cell=	\N	2025-05-18 07:52:22.54693
924	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which help in protein synthesis.\n20 the spontaneous movement of water in the cell through the region of higher concentration to the region of lower concentration is called osmosis ex absorption of water by roots \n21 plastids are only present in plants which store starch ,oils etc\n22 endoplasmic reticulum is also known as ER which form network membrane bound tubes and sheets within cell . There are two types of ER \n•rough endoplasmic reticulum RER \n• smooth endoplasmic reticulum SER \nRER is rough  because it have ribosomes which help in protein synthesis \nSER is smooth because they don't have these ribosomes present in them\n 23 golgi apparatus \nCell wall \n	\N	2025-05-18 07:52:40.620861
926	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n17. The outermost covering of cell is called plasma membrane \n It is also known as  selectively permeable membrane \nfunction= it allows some substance to enter or exit \n16. Prokaryotic cell= it have no n	\N	2025-05-18 07:52:52.666928
928	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n17. The outermost covering of cell is called plasma membrane \n It is also known as  selectively permeable membrane \nfunction= it allows some substance to enter or exit \n16. Prokaryotic cell= it have no nucleus	\N	2025-05-18 07:53:22.694941
929	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which help in protein synthesis.\n20 the spontaneous movement of water in the cell through the region of higher concentration to the region of lower concentration is called osmosis ex absorption of water by roots \n21 plastids are only present in plants which store starch ,oils etc\n22 endoplasmic reticulum is also known as ER which form network membrane bound tubes and sheets within cell . There are two types of ER \n•rough endoplasmic reticulum RER \n• smooth endoplasmic reticulum SER \nRER is rough  because it have ribosomes which help in protein synthesis \nSER is smooth because they don't have these ribosomes present in them\n 23 golgi apparatus \nCell wall \nLeu\n	\N	2025-05-18 07:53:40.604925
930	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n17. The outermost covering of cell is called plasma membrane \n It is also known as  selectively permeable membrane \nfunction= it allows some substance to enter or exit \n16. Prokaryotic cell= 1. it have no nucleus\n                      	\N	2025-05-18 07:53:52.655069
931	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which help in protein synthesis.\n20 the spontaneous movement of water in the cell through the region of higher concentration to the region of lower concentration is called osmosis ex absorption of water by roots \n21 plastids are only present in plants which store starch ,oils etc\n22 endoplasmic reticulum is also known as ER which form network membrane bound tubes and sheets within cell . There are two types of ER \n•rough endoplasmic reticulum RER \n• smooth endoplasmic reticulum SER \nRER is rough  because it have ribosomes which help in protein synthesis \nSER is smooth because they don't have these ribosomes present in them\n 23 golgi apparatus \nCell wall \nLysosome \nVacuole \nRibosomes \n	\N	2025-05-18 07:54:11.068979
932	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n17. The outermost covering of cell is called plasma membrane \n It is also known as  selectively permeable membrane \nfunction= it allows some substance to enter or exit \n16. Prokaryotic cell= 1. it have no nucleus\n                      2. It is present in  small or organic	\N	2025-05-18 07:54:22.577121
934	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which help in protein synthesis.\n20 the spontaneous movement of water in the cell through the region of higher concentration to the region of lower concentration is called osmosis ex absorption of water by roots \n21 plastids are only present in plants which store starch ,oils etc\n22 endoplasmic reticulum is also known as ER which form network membrane bound tubes and sheets within cell . There are two types of ER \n•rough endoplasmic reticulum RER \n• smooth endoplasmic reticulum SER \nRER is rough  because it have ribosomes which help in protein synthesis \nSER is smooth because they don't have these ribosomes present in them\n 23 golgi apparatus \nCell wall \nLysosome \nVacuole \nRibosomes \nNucleus \nMit\nNu	\N	2025-05-18 07:54:40.465535
936	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n17. The outermost covering of cell is called plasma membrane \n It is also known as  selectively permeable membrane \nfunction= it allows some substance to enter or exit \n16. Prokaryotic cell= 1. it have no nucleus\n                      2. It is present in  small organisms like bacteria,fungi etc	\N	2025-05-18 07:54:52.654554
937	49		\N	2025-05-18 07:55:08.287002
963	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n17. The outermost covering of cell is called plasma membrane \n It is also known as  selectively permeable membrane \nfunction= it allows some substance to enter or exit \n16. Prokaryotic cell= 1. it have no nucleus\n                      2. It is present in  small organisms like bacteria,fungi etc\nEukaryotic cell=1. It have nucleus \n                2. It is present in organism like animal,plants etc\n18. Plant cell= 1. It covered 	\N	2025-05-18 08:01:52.623762
938	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which help in protein synthesis.\n20 the spontaneous movement of water in the cell through the region of higher concentration to the region of lower concentration is called osmosis ex absorption of water by roots \n21 plastids are only present in plants which store starch ,oils etc\n22 endoplasmic reticulum is also known as ER which form network membrane bound tubes and sheets within cell . There are two types of ER \n•rough endoplasmic reticulum RER \n• smooth endoplasmic reticulum SER \nRER is rough  because it have ribosomes which help in protein synthesis \nSER is smooth because they don't have these ribosomes present in them\n 23 golgi apparatus \nCell wall \nLysosome \nVacuole \nRibosomes \nNucleus \nMitochondria \nNuclear membrane \nDNA	\N	2025-05-18 07:55:16.047325
939	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n17. The outermost covering of cell is called plasma membrane \n It is also known as  selectively permeable membrane \nfunction= it allows some substance to enter or exit \n16. Prokaryotic cell= 1. it have no nucleus\n                      2. It is present in  small organisms like bacteria,fungi etc\nEukaryotic cell=1. It have nucleus \n	\N	2025-05-18 07:55:22.6982
940	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which help in protein synthesis.\n20 the spontaneous movement of water in the cell through the region of higher concentration to the region of lower concentration is called osmosis ex absorption of water by roots \n21 plastids are only present in plants which store starch ,oils etc\n22 endoplasmic reticulum is also known as ER which form network membrane bound tubes and sheets within cell . There are two types of ER \n•rough endoplasmic reticulum RER \n• smooth endoplasmic reticulum SER \nRER is rough  because it have ribosomes which help in protein synthesis \nSER is smooth because they don't have these ribosomes present in them\n 23 golgi apparatus \nCell wall \nLysosome \nVacuole \nRibosomes \nNucleus \nMitochondria \nNuclear membrane \nDNA\n24	\N	2025-05-18 07:55:41.067062
942	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n17. The outermost covering of cell is called plasma membrane \n It is also known as  selectively permeable membrane \nfunction= it allows some substance to enter or exit \n16. Prokaryotic cell= 1. it have no nucleus\n                      2. It is present in  small organisms like bacteria,fungi etc\nEukaryotic cell=1. It have nucleus \n                2. It is present in organism like animal 	\N	2025-05-18 07:55:53.220429
943	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n17. The outermost covering of cell is called plasma membrane \n It is also known as  selectively permeable membrane \nfunction= it allows some substance to enter or exit \n16. Prokaryotic cell= 1. it have no nucleus\n                      2. It is present in  small organisms like bacteria,fungi etc\nEukaryotic cell=1. It have nucleus \n                2. It is present in organism like animal,plants etc\n18.	\N	2025-05-18 07:56:22.681103
945	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which help in protein synthesis.\n20 the spontaneous movement of water in the cell through the region of higher concentration to the region of lower concentration is called osmosis ex absorption of water by roots \n21 plastids are only present in plants which store starch ,oils etc\n22 endoplasmic reticulum is also known as ER which form network membrane bound tubes and sheets within cell . There are two types of ER \n•rough endoplasmic reticulum RER \n• smooth endoplasmic reticulum SER \nRER is rough  because it have ribosomes which help in protein synthesis \nSER is smooth because they don't have these ribosomes present in them\n 23 golgi apparatus \nCell wall \nLysosome \nVacuole \nRibosomes \nNucleus \nMitochondria \nNuclear membrane \nDNA\n24 it is outer covering of the cell	\N	2025-05-18 07:57:11.049373
950	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which help in protein synthesis.\n20 the spontaneous movement of water in the cell through the region of higher concentration to the region of lower concentration is called osmosis ex absorption of water by roots \n21 plastids are only present in plants which store starch ,oils etc\n22 endoplasmic reticulum is also known as ER which form network membrane bound tubes and sheets within cell . There are two types of ER \n•rough endoplasmic reticulum RER \n• smooth endoplasmic reticulum SER \nRER is rough  because it have ribosomes which help in protein synthesis \nSER is smooth because they don't have these ribosomes present in them\n 23 golgi apparatus \nCell wall \nLysosome \nVacuole \nRibosomes \nNucleus \nMitochondria \nNuclear membrane \nDNA\n24 it is outer covering of the cell\n25 	\N	2025-05-18 07:58:40.982496
952	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which help in protein synthesis.\n20 the spontaneous movement of water in the cell through the region of higher concentration to the region of lower concentration is called osmosis ex absorption of water by roots \n21 plastids are only present in plants which store starch ,oils etc\n22 endoplasmic reticulum is also known as ER which form network membrane bound tubes and sheets within cell . There are two types of ER \n•rough endoplasmic reticulum RER \n• smooth endoplasmic reticulum SER \nRER is rough  because it have ribosomes which help in protein synthesis \nSER is smooth because they don't have these ribosomes present in them\n 23 golgi apparatus \nCell wall \nLysosome \nVacuole \nRibosomes \nNucleus \nMitochondria \nNuclear membrane \nDNA\n24 it is outer covering of the cell\n25 the shrinkage of cytoplasm from the 	\N	2025-05-18 07:59:10.471427
954	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which help in protein synthesis.\n20 the spontaneous movement of water in the cell through the region of higher concentration to the region of lower concentration is called osmosis ex absorption of water by roots \n21 plastids are only present in plants which store starch ,oils etc\n22 endoplasmic reticulum is also known as ER which form network membrane bound tubes and sheets within cell . There are two types of ER \n•rough endoplasmic reticulum RER \n• smooth endoplasmic reticulum SER \nRER is rough  because it have ribosomes which help in protein synthesis \nSER is smooth because they don't have these ribosomes present in them\n 23 golgi apparatus \nCell wall \nLysosome \nVacuole \nRibosomes \nNucleus \nMitochondria \nNuclear membrane \nDNA\n24 it is outer covering of the cell\n25 the shrinkage of cytoplasm from the cell wall under hypertonic solution is known as plasmolysis \n26	\N	2025-05-18 07:59:41.054125
958	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n17. The outermost covering of cell is called plasma membrane \n It is also known as  selectively permeable membrane \nfunction= it allows some substance to enter or exit \n16. Prokaryotic cell= 1. it have no nucleus\n                      2. It is present in  small organisms like bacteria,fungi etc\nEukaryotic cell=1. It have nucleus \n                2. It is present in organism like animal,plants etc\n18. Pl	\N	2025-05-18 08:00:52.607071
959	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which help in protein synthesis.\n20 the spontaneous movement of water in the cell through the region of higher concentration to the region of lower concentration is called osmosis ex absorption of water by roots \n21 plastids are only present in plants which store starch ,oils etc\n22 endoplasmic reticulum is also known as ER which form network membrane bound tubes and sheets within cell . There are two types of ER \n•rough endoplasmic reticulum RER \n• smooth endoplasmic reticulum SER \nRER is rough  because it have ribosomes which help in protein synthesis \nSER is smooth because they don't have these ribosomes present in them\n 23 golgi apparatus \nCell wall \nLysosome \nVacuole \nRibosomes \nNucleus \nMitochondria \nNuclear membrane \nDNA\n24 it is outer covering of the cell\n25 the shrinkage of cytoplasm from the cell wall under hypertonic solution is known as plasmolysis \n26 mi	\N	2025-05-18 08:01:16.086822
960	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n17. The outermost covering of cell is called plasma membrane \n It is also known as  selectively permeable membrane \nfunction= it allows some substance to enter or exit \n16. Prokaryotic cell= 1. it have no nucleus\n                      2. It is present in  small organisms like bacteria,fungi etc\nEukaryotic cell=1. It have nucleus \n                2. It is present in organism like animal,plants etc\n18. Plant cell	\N	2025-05-18 08:01:22.679862
961	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which help in protein synthesis.\n20 the spontaneous movement of water in the cell through the region of higher concentration to the region of lower concentration is called osmosis ex absorption of water by roots \n21 plastids are only present in plants which store starch ,oils etc\n22 endoplasmic reticulum is also known as ER which form network membrane bound tubes and sheets within cell . There are two types of ER \n•rough endoplasmic reticulum RER \n• smooth endoplasmic reticulum SER \nRER is rough  because it have ribosomes which help in protein synthesis \nSER is smooth because they don't have these ribosomes present in them\n 23 golgi apparatus \nCell wall \nLysosome \nVacuole \nRibosomes \nNucleus \nMitochondria \nNuclear membrane \nDNA\n24 it is outer covering of the cell\n25 the shrinkage of cytoplasm from the cell wall under hypertonic solution is known as plasmolysis \n26 mitochondria is called the powerhouse of cell because 	\N	2025-05-18 08:01:41.045873
964	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which help in protein synthesis.\n20 the spontaneous movement of water in the cell through the region of higher concentration to the region of lower concentration is called osmosis ex absorption of water by roots \n21 plastids are only present in plants which store starch ,oils etc\n22 endoplasmic reticulum is also known as ER which form network membrane bound tubes and sheets within cell . There are two types of ER \n•rough endoplasmic reticulum RER \n• smooth endoplasmic reticulum SER \nRER is rough  because it have ribosomes which help in protein synthesis \nSER is smooth because they don't have these ribosomes present in them\n 23 golgi apparatus \nCell wall \nLysosome \nVacuole \nRibosomes \nNucleus \nMitochondria \nNuclear membrane \nDNA\n24 it is outer covering of the cell\n25 the shrinkage of cytoplasm from the cell wall under hypertonic solution is known as plasmolysis \n26 mitochondria is called the powerhouse of cell becaushee 	\N	2025-05-18 08:02:10.499692
966	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n17. The outermost covering of cell is called plasma membrane \n It is also known as  selectively permeable membrane \nfunction= it allows some substance to enter or exit \n16. Prokaryotic cell= 1. it have no nucleus\n                      2. It is present in  small organisms like bacteria,fungi etc\nEukaryotic cell=1. It have nucleus \n                2. It is present in organism like animal,plants etc\n18. Plant cell= 1. It covered by  cell wall \n2. It  h	\N	2025-05-18 08:02:22.545391
967	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which help in protein synthesis.\n20 the spontaneous movement of water in the cell through the region of higher concentration to the region of lower concentration is called osmosis ex absorption of water by roots \n21 plastids are only present in plants which store starch ,oils etc\n22 endoplasmic reticulum is also known as ER which form network membrane bound tubes and sheets within cell . There are two types of ER \n•rough endoplasmic reticulum RER \n• smooth endoplasmic reticulum SER \nRER is rough  because it have ribosomes which help in protein synthesis \nSER is smooth because they don't have these ribosomes present in them\n 23 golgi apparatus \nCell wall \nLysosome \nVacuole \nRibosomes \nNucleus \nMitochondria \nNuclear membrane \nDNA\n24 it is outer covering of the cell\n25 the shrinkage of cytoplasm from the cell wall under hypertonic solution is known as plasmolysis \n26 mitochondria is called the powerhouse of cell because here energy is converted into ATP	\N	2025-05-18 08:02:40.552531
969	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n17. The outermost covering of cell is called plasma membrane \n It is also known as  selectively permeable membrane \nfunction= it allows some substance to enter or exit \n16. Prokaryotic cell= 1. it have no nucleus\n                      2. It is present in  small organisms like bacteria,fungi etc\nEukaryotic cell=1. It have nucleus \n                2. It is present in organism like animal,plants etc\n18. Plant cell= 1. It covered by  cell wall \n                2. It  have mitochondria \n	\N	2025-05-18 08:02:52.541968
971	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n17. The outermost covering of cell is called plasma membrane \n It is also known as  selectively permeable membrane \nfunction= it allows some substance to enter or exit \n16. Prokaryotic cell= 1. it have no nucleus\n                      2. It is present in  small organisms like bacteria,fungi etc\nEukaryotic cell=1. It have nucleus \n                2. It is present in organism like animal,plants etc\n18. Plant cell= 1. It covered by  cell wall \n                2. It  have mitochondria \nAnimal cell =it covered by plasma membrane \n             	\N	2025-05-18 08:03:22.715032
973	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n17. The outermost covering of cell is called plasma membrane \n It is also known as  selectively permeable membrane \nfunction= it allows some substance to enter or exit \n16. Prokaryotic cell= 1. it have no nucleus\n                      2. It is present in  small organisms like bacteria,fungi etc\nEukaryotic cell=1. It have nucleus \n                2. It is present in organism like animal,plants etc\n18. Plant cell= 1. It covered by  cell wall \n                2. It  have mitochondria \nAnimal cell = 1.it covered by plasma membrane \n              2. It doesn't not have mitochondria\n	\N	2025-05-18 08:03:52.714989
975	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n17. The outermost covering of cell is called plasma membrane \n It is also known as  selectively permeable membrane \nfunction= it allows some substance to enter or exit \n16. Prokaryotic cell= 1. it have no nucleus\n                      2. It is present in  small organisms like bacteria,fungi etc\nEukaryotic cell=1. It have nucleus \n                2. It is present in organism like animal,plants etc\n18. Plant cell= 1. It covered by  cell wall \n                2. It  have mitochondria \nAnimal cell = 1.it covered by plasma membrane \n              2. It doesn't not have mitochondria\n22. It have to type of e endogenic reticulum	\N	2025-05-18 08:04:52.692991
976	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which help in protein synthesis.\n20 the spontaneous movement of water in the cell through the region of higher concentration to the region of lower concentration is called osmosis ex absorption of water by roots \n21 plastids are only present in plants which store starch ,oils etc\n22 endoplasmic reticulum is also known as ER which form network membrane bound tubes and sheets within cell . There are two types of ER \n•rough endoplasmic reticulum RER \n• smooth endoplasmic reticulum SER \nRER is rough  because it have ribosomes which help in protein synthesis \nSER is smooth because they don't have these ribosomes present in them\n 23 golgi apparatus \nCell wall \nLysosome \nVacuole \nRibosomes \nNucleus \nMitochondria \nNuclear membrane \nDNA\n24 it is outer covering of the cell\n25 the shrinkage of cytoplasm from the cell wall under hypertonic solution is known as plasmolysis \n26 mitochondria is called the powerhouse of cell because here energy is converted into ATP\n27 	\N	2025-05-18 08:05:10.41887
977	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n17. The outermost covering of cell is called plasma membrane \n It is also known as  selectively permeable membrane \nfunction= it allows some substance to enter or exit \n16. Prokaryotic cell= 1. it have no nucleus\n                      2. It is present in  small organisms like bacteria,fungi etc\nEukaryotic cell=1. It have nucleus \n                2. It is present in organism like animal,plants etc\n18. Plant cell= 1. It covered by  cell wall \n                2. It  have mitochondria \nAnimal cell = 1.it covered by plasma membrane \n              2. It doesn't not have mitochondria\n22. It have to type of  endoplasmic reticulum \n1. Rou	\N	2025-05-18 08:05:22.707074
978	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which help in protein synthesis.\n20 the spontaneous movement of water in the cell through the region of higher concentration to the region of lower concentration is called osmosis ex absorption of water by roots \n21 plastids are only present in plants which store starch ,oils etc\n22 endoplasmic reticulum is also known as ER which form network membrane bound tubes and sheets within cell . There are two types of ER \n•rough endoplasmic reticulum RER \n• smooth endoplasmic reticulum SER \nRER is rough  because it have ribosomes which help in protein synthesis \nSER is smooth because they don't have these ribosomes present in them\n 23 golgi apparatus \nCell wall \nLysosome \nVacuole \nRibosomes \nNucleus \nMitochondria \nNuclear membrane \nDNA\n24 it is outer covering of the cell\n25 the shrinkage of cytoplasm from the cell wall under hypertonic solution is known as plasmolysis \n26 mitochondria is called the powerhouse of cell because here energy is converted into ATP\n27 1 the raisins had swelling 	\N	2025-05-18 08:05:41.047387
979	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n17. The outermost covering of cell is called plasma membrane \n It is also known as  selectively permeable membrane \nfunction= it allows some substance to enter or exit \n16. Prokaryotic cell= 1. it have no nucleus\n                      2. It is present in  small organisms like bacteria,fungi etc\nEukaryotic cell=1. It have nucleus \n                2. It is present in organism like animal,plants etc\n18. Plant cell= 1. It covered by  cell wall \n                2. It  have mitochondria \nAnimal cell = 1.it covered by plasma membrane \n              2. It doesn't not have mitochondria\n22. It have to type of  endoplasmic reticulum \n1. Rough endoplasmic reticulum \n2.smooth endoplasmic reticulum \n	\N	2025-05-18 08:05:52.857769
991	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which help in protein synthesis.\n20 the spontaneous movement of water in the cell through the region of higher concentration to the region of lower concentration is called osmosis ex absorption of water by roots \n21 plastids are only present in plants which store starch ,oils etc\n22 endoplasmic reticulum is also known as ER which form network membrane bound tubes and sheets within cell . There are two types of ER \n•rough endoplasmic reticulum RER \n• smooth endoplasmic reticulum SER \nRER is rough  because it have ribosomes which help in protein synthesis \nSER is smooth because they don't have these ribosomes present in them\n 23 golgi apparatus \nCell wall \nLysosome \nVacuole \nRibosomes \nNucleus \nMitochondria \nNuclear membrane \nDNA\n24 it is outer covering of the cell\n25 the shrinkage of cytoplasm from the cell wall under hypertonic solution is known as plasmolysis \n26 mitochondria is called the powerhouse of cell because here energy is converted into ATP\n27 1 osmosis\n2 the water surrounding the cell has\n2	\N	2025-05-18 08:10:43.796903
982	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which help in protein synthesis.\n20 the spontaneous movement of water in the cell through the region of higher concentration to the region of lower concentration is called osmosis ex absorption of water by roots \n21 plastids are only present in plants which store starch ,oils etc\n22 endoplasmic reticulum is also known as ER which form network membrane bound tubes and sheets within cell . There are two types of ER \n•rough endoplasmic reticulum RER \n• smooth endoplasmic reticulum SER \nRER is rough  because it have ribosomes which help in protein synthesis \nSER is smooth because they don't have these ribosomes present in them\n 23 golgi apparatus \nCell wall \nLysosome \nVacuole \nRibosomes \nNucleus \nMitochondria \nNuclear membrane \nDNA\n24 it is outer covering of the cell\n25 the shrinkage of cytoplasm from the cell wall under hypertonic solution is known as plasmolysis \n26 mitochondria is called the powerhouse of cell because here energy is converted into ATP\n27 1 the 	\N	2025-05-18 08:08:14.38544
985	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which help in protein synthesis.\n20 the spontaneous movement of water in the cell through the region of higher concentration to the region of lower concentration is called osmosis ex absorption of water by roots \n21 plastids are only present in plants which store starch ,oils etc\n22 endoplasmic reticulum is also known as ER which form network membrane bound tubes and sheets within cell . There are two types of ER \n•rough endoplasmic reticulum RER \n• smooth endoplasmic reticulum SER \nRER is rough  because it have ribosomes which help in protein synthesis \nSER is smooth because they don't have these ribosomes present in them\n 23 golgi apparatus \nCell wall \nLysosome \nVacuole \nRibosomes \nNucleus \nMitochondria \nNuclear membrane \nDNA\n24 it is outer covering of the cell\n25 the shrinkage of cytoplasm from the cell wall under hypertonic solution is known as plasmolysis \n26 mitochondria is called the powerhouse of cell because here energy is converted into ATP\n27 1 when the medium has higher concentration the contents	\N	2025-05-18 08:09:13.926517
987	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which help in protein synthesis.\n20 the spontaneous movement of water in the cell through the region of higher concentration to the region of lower concentration is called osmosis ex absorption of water by roots \n21 plastids are only present in plants which store starch ,oils etc\n22 endoplasmic reticulum is also known as ER which form network membrane bound tubes and sheets within cell . There are two types of ER \n•rough endoplasmic reticulum RER \n• smooth endoplasmic reticulum SER \nRER is rough  because it have ribosomes which help in protein synthesis \nSER is smooth because they don't have these ribosomes present in them\n 23 golgi apparatus \nCell wall \nLysosome \nVacuole \nRibosomes \nNucleus \nMitochondria \nNuclear membrane \nDNA\n24 it is outer covering of the cell\n25 the shrinkage of cytoplasm from the cell wall under hypertonic solution is known as plasmolysis \n26 mitochondria is called the powerhouse of cell because here energy is converted into ATP\n27 1 when the medium has higher concentration the content will swell up\n2	\N	2025-05-18 08:09:44.41272
989	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which help in protein synthesis.\n20 the spontaneous movement of water in the cell through the region of higher concentration to the region of lower concentration is called osmosis ex absorption of water by roots \n21 plastids are only present in plants which store starch ,oils etc\n22 endoplasmic reticulum is also known as ER which form network membrane bound tubes and sheets within cell . There are two types of ER \n•rough endoplasmic reticulum RER \n• smooth endoplasmic reticulum SER \nRER is rough  because it have ribosomes which help in protein synthesis \nSER is smooth because they don't have these ribosomes present in them\n 23 golgi apparatus \nCell wall \nLysosome \nVacuole \nRibosomes \nNucleus \nMitochondria \nNuclear membrane \nDNA\n24 it is outer covering of the cell\n25 the shrinkage of cytoplasm from the cell wall under hypertonic solution is known as plasmolysis \n26 mitochondria is called the powerhouse of cell because here energy is converted into ATP\n27 1 osmosis\n2 \n2	\N	2025-05-18 08:10:20.458335
992	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n17. The outermost covering of cell is called plasma membrane \n It is also known as  selectively permeable membrane \nfunction= it allows some substance to enter or exit \n16. Prokaryotic cell= 1. it have no nucleus\n                      2. It is present in  small organisms like bacteria,fungi etc\nEukaryotic cell=1. It have nucleus \n                2. It is present in organism like animal,plants etc\n18. Plant cell= 1. It covered by  cell wall \n                2. It  have mitochondria \nAnimal cell = 1.it covered by plasma membrane \n              2. It doesn't not have mitochondria\n22. It have to type of  endoplasmic reticulum \n1. Rough endoplasmic reticulum \n2.smooth endoplasmic reticulum \n19.	\N	2025-05-18 08:11:04.692148
993	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which help in protein synthesis.\n20 the spontaneous movement of water in the cell through the region of higher concentration to the region of lower concentration is called osmosis ex absorption of water by roots \n21 plastids are only present in plants which store starch ,oils etc\n22 endoplasmic reticulum is also known as ER which form network membrane bound tubes and sheets within cell . There are two types of ER \n•rough endoplasmic reticulum RER \n• smooth endoplasmic reticulum SER \nRER is rough  because it have ribosomes which help in protein synthesis \nSER is smooth because they don't have these ribosomes present in them\n 23 golgi apparatus \nCell wall \nLysosome \nVacuole \nRibosomes \nNucleus \nMitochondria \nNuclear membrane \nDNA\n24 it is outer covering of the cell\n25 the shrinkage of cytoplasm from the cell wall under hypertonic solution is known as plasmolysis \n26 mitochondria is called the powerhouse of cell because here energy is converted into ATP\n27 1 osmosis\n2 the water surrounding the cell has more concentration of water as compared to the water present inside the \n2	\N	2025-05-18 08:11:13.774922
994	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n17. The outermost covering of cell is called plasma membrane \n It is also known as  selectively permeable membrane \nfunction= it allows some substance to enter or exit \n16. Prokaryotic cell= 1. it have no nucleus\n                      2. It is present in  small organisms like bacteria,fungi etc\nEukaryotic cell=1. It have nucleus \n                2. It is present in organism like animal,plants etc\n18. Plant cell= 1. It covered by  cell wall \n                2. It  have mitochondria \nAnimal cell = 1.it covered by plasma membrane \n              2. It doesn't not have mitochondria\n22. It have to type of  endoplasmic reticulum \n1. Rough endoplasmic reticulum \n2.smooth endoplasmic reticulum \n19.it contain the 	\N	2025-05-18 08:11:34.969194
995	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which help in protein synthesis.\n20 the spontaneous movement of water in the cell through the region of higher concentration to the region of lower concentration is called osmosis ex absorption of water by roots \n21 plastids are only present in plants which store starch ,oils etc\n22 endoplasmic reticulum is also known as ER which form network membrane bound tubes and sheets within cell . There are two types of ER \n•rough endoplasmic reticulum RER \n• smooth endoplasmic reticulum SER \nRER is rough  because it have ribosomes which help in protein synthesis \nSER is smooth because they don't have these ribosomes present in them\n 23 golgi apparatus \nCell wall \nLysosome \nVacuole \nRibosomes \nNucleus \nMitochondria \nNuclear membrane \nDNA\n24 it is outer covering of the cell\n25 the shrinkage of cytoplasm from the cell wall under hypertonic solution is known as plasmolysis \n26 mitochondria is called the powerhouse of cell because here energy is converted into ATP\n27 1 osmosis\n2 the water surrounding the cell has more concentration of water as compared to the water present inside the cell \n3 \n2	\N	2025-05-18 08:11:44.401066
996	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n17. The outermost covering of cell is called plasma membrane \n It is also known as  selectively permeable membrane \nfunction= it allows some substance to enter or exit \n16. Prokaryotic cell= 1. it have no nucleus\n                      2. It is present in  small organisms like bacteria,fungi etc\nEukaryotic cell=1. It have nucleus \n                2. It is present in organism like animal,plants etc\n18. Plant cell= 1. It covered by  cell wall \n                2. It  have mitochondria \nAnimal cell = 1.it covered by plasma membrane \n              2. It doesn't not have mitochondria\n22. It have to type of  endoplasmic reticulum \n1. Rough endoplasmic reticulum \n2.smooth endoplasmic reticulum \n19.it contain the cell's here	\N	2025-05-18 08:12:04.450879
997	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n17. The outermost covering of cell is called plasma membrane \n It is also known as  selectively permeable membrane \nfunction= it allows some substance to enter or exit \n16. Prokaryotic cell= 1. it have no nucleus\n                      2. It is present in  small organisms like bacteria,fungi etc\nEukaryotic cell=1. It have nucleus \n                2. It is present in organism like animal,plants etc\n18. Plant cell= 1. It covered by  cell wall \n                2. It  have mitochondria \nAnimal cell = 1.it covered by plasma membrane \n              2. It doesn't not have mitochondria\n22. It have to type of  endoplasmic reticulum \n1. Rough endoplasmic reticulum \n2.smooth endoplasmic reticulum \n19.it contain the cell's hereditary information and conte	\N	2025-05-18 08:12:35.136709
999	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n17. The outermost covering of cell is called plasma membrane \n It is also known as  selectively permeable membrane \nfunction= it allows some substance to enter or exit \n16. Prokaryotic cell= 1. it have no nucleus\n                      2. It is present in  small organisms like bacteria,fungi etc\nEukaryotic cell=1. It have nucleus \n                2. It is present in organism like animal,plants etc\n18. Plant cell= 1. It covered by  cell wall \n                2. It  have mitochondria \nAnimal cell = 1.it covered by plasma membrane \n              2. It doesn't not have mitochondria\n22. It have to type of  endoplasmic reticulum \n1. Rough endoplasmic reticulum \n2.smooth endoplasmic reticulum \n19.it contain the cell's hereditary information and control of cell 's	\N	2025-05-18 08:13:04.317071
1001	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which help in protein synthesis.\n20 the spontaneous movement of water in the cell through the region of higher concentration to the region of lower concentration is called osmosis ex absorption of water by roots \n21 plastids are only present in plants which store starch ,oils etc\n22 endoplasmic reticulum is also known as ER which form network membrane bound tubes and sheets within cell . There are two types of ER \n•rough endoplasmic reticulum RER \n• smooth endoplasmic reticulum SER \nRER is rough  because it have ribosomes which help in protein synthesis \nSER is smooth because they don't have these ribosomes present in them\n 23 golgi apparatus \nCell wall \nLysosome \nVacuole \nRibosomes \nNucleus \nMitochondria \nNuclear membrane \nDNA\n24 it is outer covering of the cell\n25 the shrinkage of cytoplasm from the cell wall under hypertonic solution is known as plasmolysis \n26 mitochondria is called the powerhouse of cell because here energy is converted into ATP\n27 1 osmosis\n2 the water surrounding the cell has more concentration of water as compared to the water present inside the cell \n3 the cell will shrink because sugar solution h\n2	\N	2025-05-18 08:13:14.525175
1003	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n17. The outermost covering of cell is called plasma membrane \n It is also known as  selectively permeable membrane \nfunction= it allows some substance to enter or exit \n16. Prokaryotic cell= 1. it have no nucleus\n                      2. It is present in  small organisms like bacteria,fungi etc\nEukaryotic cell=1. It have nucleus \n                2. It is present in organism like animal,plants etc\n18. Plant cell= 1. It covered by  cell wall \n                2. It  have mitochondria \nAnimal cell = 1.it covered by plasma membrane \n              2. It doesn't not have mitochondria\n22. It have to type of  endoplasmic reticulum \n1. Rough endoplasmic reticulum \n2.smooth endoplasmic reticulum \n19.it contain the cell's hereditary information and control of cell 's growth and reproduction	\N	2025-05-18 08:13:34.468396
1006	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which help in protein synthesis.\n20 the spontaneous movement of water in the cell through the region of higher concentration to the region of lower concentration is called osmosis ex absorption of water by roots \n21 plastids are only present in plants which store starch ,oils etc\n22 endoplasmic reticulum is also known as ER which form network membrane bound tubes and sheets within cell . There are two types of ER \n•rough endoplasmic reticulum RER \n• smooth endoplasmic reticulum SER \nRER is rough  because it have ribosomes which help in protein synthesis \nSER is smooth because they don't have these ribosomes present in them\n 23 golgi apparatus \nCell wall \nLysosome \nVacuole \nRibosomes \nNucleus \nMitochondria \nNuclear membrane \nDNA\n24 it is outer covering of the cell\n25 the shrinkage of cytoplasm from the cell wall under hypertonic solution is known as plasmolysis \n26 mitochondria is called the powerhouse of cell because here energy is converted into ATP\n27 1 osmosis\n2 the water surrounding the cell has more concentration of water as compared to the water present inside the cell \n3 the cell will shrink because sugar solution has lower concentration of watera\n2	\N	2025-05-18 08:13:43.78318
1007	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n17. The outermost covering of cell is called plasma membrane \n It is also known as  selectively permeable membrane \nfunction= it allows some substance to enter or exit \n16. Prokaryotic cell= 1. it have no nucleus\n                      2. It is present in  small organisms like bacteria,fungi etc\nEukaryotic cell=1. It have nucleus \n                2. It is present in organism like animal,plants etc\n18. Plant cell= 1. It covered by  cell wall \n                2. It  have mitochondria \nAnimal cell = 1.it covered by plasma membrane \n              2. It doesn't not have mitochondria\n22. It have to type of  endoplasmic reticulum \n1. Rough endoplasmic reticulum \n2.smooth endoplasmic reticulum \n19.it contain the cell's hereditary information and control of cell 's growth and reproduction \n21.	\N	2025-05-18 08:14:05.380956
1008	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which help in protein synthesis.\n20 the spontaneous movement of water in the cell through the region of higher concentration to the region of lower concentration is called osmosis ex absorption of water by roots \n21 plastids are only present in plants which store starch ,oils etc\n22 endoplasmic reticulum is also known as ER which form network membrane bound tubes and sheets within cell . There are two types of ER \n•rough endoplasmic reticulum RER \n• smooth endoplasmic reticulum SER \nRER is rough  because it have ribosomes which help in protein synthesis \nSER is smooth because they don't have these ribosomes present in them\n 23 golgi apparatus \nCell wall \nLysosome \nVacuole \nRibosomes \nNucleus \nMitochondria \nNuclear membrane \nDNA\n24 it is outer covering of the cell\n25 the shrinkage of cytoplasm from the cell wall under hypertonic solution is known as plasmolysis \n26 mitochondria is called the powerhouse of cell because here energy is converted into ATP\n27 1 osmosis\n2 the water surrounding the cell has more concentration of water as compared to the water present inside the cell \n3 the cell will shrink because sugar solution has lower concentration of water and swollen cell have more water concentration \n2	\N	2025-05-18 08:14:13.815485
1009	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which help in protein synthesis.\n20 the spontaneous movement of water in the cell through the region of higher concentration to the region of lower concentration is called osmosis ex absorption of water by roots \n21 plastids are only present in plants which store starch ,oils etc\n22 endoplasmic reticulum is also known as ER which form network membrane bound tubes and sheets within cell . There are two types of ER \n•rough endoplasmic reticulum RER \n• smooth endoplasmic reticulum SER \nRER is rough  because it have ribosomes which help in protein synthesis \nSER is smooth because they don't have these ribosomes present in them\n 23 golgi apparatus \nCell wall \nLysosome \nVacuole \nRibosomes \nNucleus \nMitochondria \nNuclear membrane \nDNA\n24 it is outer covering of the cell\n25 the shrinkage of cytoplasm from the cell wall under hypertonic solution is known as plasmolysis \n26 mitochondria is called the powerhouse of cell because here energy is converted into ATP\n27 1 osmosis\n2 the water surrounding the cell has more concentration of water as compared to the water present inside the cell \n3 the cell will shrink because sugar solution has lower concentration of water and swollen cell have more water concentration \n4\n2	\N	2025-05-18 08:14:43.878445
1010	48	1c\n2b\n3c\n4b\n5c\n6d\n7d\n8c\n9c\n10c\n11a\n12b\n13a\n14b\n15b	\N	2025-05-18 08:14:51.579149
1011	48		\N	2025-05-18 08:14:52.65693
1012	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which help in protein synthesis.\n20 the spontaneous movement of water in the cell through the region of higher concentration to the region of lower concentration is called osmosis ex absorption of water by roots \n21 plastids are only present in plants which store starch ,oils etc\n22 endoplasmic reticulum is also known as ER which form network membrane bound tubes and sheets within cell . There are two types of ER \n•rough endoplasmic reticulum RER \n• smooth endoplasmic reticulum SER \nRER is rough  because it have ribosomes which help in protein synthesis \nSER is smooth because they don't have these ribosomes present in them\n 23 golgi apparatus \nCell wall \nLysosome \nVacuole \nRibosomes \nNucleus \nMitochondria \nNuclear membrane \nDNA\n24 it is outer covering of the cell\n25 the shrinkage of cytoplasm from the cell wall under hypertonic solution is known as plasmolysis \n26 mitochondria is called the powerhouse of cell because here energy is converted into ATP\n27 1 osmosis\n2 the water surrounding the cell has more concentration of water as compared to the water present inside the cell \n3 the cell will shrink because sugar solution has lower concentration of water and swollen cell have more water concentration \n4 they will shrink \n2	\N	2025-05-18 08:15:14.362991
1013	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which help in protein synthesis.\n20 the spontaneous movement of water in the cell through the region of higher concentration to the region of lower concentration is called osmosis ex absorption of water by roots \n21 plastids are only present in plants which store starch ,oils etc\n22 endoplasmic reticulum is also known as ER which form network membrane bound tubes and sheets within cell . There are two types of ER \n•rough endoplasmic reticulum RER \n• smooth endoplasmic reticulum SER \nRER is rough  because it have ribosomes which help in protein synthesis \nSER is smooth because they don't have these ribosomes present in them\n 23 golgi apparatus \nCell wall \nLysosome \nVacuole \nRibosomes \nNucleus \nMitochondria \nNuclear membrane \nDNA\n24 it is outer covering of the cell\n25 the shrinkage of cytoplasm from the cell wall under hypertonic solution is known as plasmolysis \n26 mitochondria is called the powerhouse of cell because here energy is converted into ATP\n27 1 osmosis\n2 the water surrounding the cell has more concentration of water as compared to the water present inside the cell \n3 the cell will shrink because sugar solution has lower concentration of water and swollen cell have more water concentration \n4 they will shrink \n5 when we boil potatoes the pota	\N	2025-05-18 08:15:43.789577
1014	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n17. The outermost covering of cell is called plasma membrane \n It is also known as  selectively permeable membrane \nfunction= it allows some substance to enter or exit \n16. Prokaryotic cell= 1. it have no nucleus\n                      2. It is present in  small organisms like bacteria,fungi etc\nEukaryotic cell=1. It have nucleus \n                2. It is present in organism like animal,plants etc\n18. Plant cell= 1. It covered by  cell wall \n                2. It  have mitochondria \nAnimal cell = 1.it covered by plasma membrane \n              2. It doesn't not have mitochondria\n22. It have to type of  endoplasmic reticulum \n1. Rough endoplasmic reticulum \n2.smooth endoplasmic reticulum \n19.it contain the cell's hereditary information and control of cell 's growth and reproduction \n21.plastid are double membrane 	\N	2025-05-18 08:16:04.875262
1015	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which help in protein synthesis.\n20 the spontaneous movement of water in the cell through the region of higher concentration to the region of lower concentration is called osmosis ex absorption of water by roots \n21 plastids are only present in plants which store starch ,oils etc\n22 endoplasmic reticulum is also known as ER which form network membrane bound tubes and sheets within cell . There are two types of ER \n•rough endoplasmic reticulum RER \n• smooth endoplasmic reticulum SER \nRER is rough  because it have ribosomes which help in protein synthesis \nSER is smooth because they don't have these ribosomes present in them\n 23 golgi apparatus \nCell wall \nLysosome \nVacuole \nRibosomes \nNucleus \nMitochondria \nNuclear membrane \nDNA\n24 it is outer covering of the cell\n25 the shrinkage of cytoplasm from the cell wall under hypertonic solution is known as plasmolysis \n26 mitochondria is called the powerhouse of cell because here energy is converted into ATP\n27 1 osmosis\n2 the water surrounding the cell has more concentration of water as compared to the water present inside the cell \n3 the cell will shrink because sugar solution has lower concentration of water and swollen cell have more water concentration \n4 they will shrink \n5 when we boil potatoes the potatoes will swell up.\n	\N	2025-05-18 08:16:13.785182
1018	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n17. The outermost covering of cell is called plasma membrane \n It is also known as  selectively permeable membrane \nfunction= it allows some substance to enter or exit \n16. Prokaryotic cell= 1. it have no nucleus\n                      2. It is present in  small organisms like bacteria,fungi etc\nEukaryotic cell=1. It have nucleus \n                2. It is present in organism like animal,plants etc\n18. Plant cell= 1. It covered by  cell wall \n                2. It  have mitochondria \nAnimal cell = 1.it covered by plasma membrane \n              2. It doesn't not have mitochondria\n22. It have to type of  endoplasmic reticulum \n1. Rough endoplasmic reticulum \n2.smooth endoplasmic reticulum \n19.it contain the cell's hereditary information and control of cell 's growth and reproduction \n21.plastid are double membrane organelles which found in the cell plant and algae\n	\N	2025-05-18 08:17:04.558872
1019	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n17. The outermost covering of cell is called plasma membrane \n It is also known as  selectively permeable membrane \nfunction= it allows some substance to enter or exit \n16. Prokaryotic cell= 1. it have no nucleus\n                      2. It is present in  small organisms like bacteria,fungi etc\nEukaryotic cell=1. It have nucleus \n                2. It is present in organism like animal,plants etc\n18. Plant cell= 1. It covered by  cell wall \n                2. It  have mitochondria \nAnimal cell = 1.it covered by plasma membrane \n              2. It doesn't not have mitochondria\n22. It have to type of  endoplasmic reticulum \n1. Rough endoplasmic reticulum \n2.smooth endoplasmic reticulum \n19.it contain the cell's hereditary information and control of cell 's growth and reproduction \n21.plastid are double membrane organelles which found in the cell plant and algae\nIt have three types1. 	\N	2025-05-18 08:17:35.543768
1020	46	1 cell\n2 cell wall\n3  mitochondria \n4 synthesize protein \n5 protoplasm \n6 golgi apparatus \n7 animals \n8 nucleus \n9 plasmolysis \n10 chloroplast \n11 a) both a and r are true and r is the correct explanation of a\n12 a) both a and r are true and r is the correct explanation of a\n13 a) both a and r are true and r is the correct explanation of a \n14 b) both a and r are true and r is not the correct explanation of a\n15 a ) both a and r are true and r is correct explanation of a\n16 prokaryotic cells :-• the size of these cells are generally small\n• the nuclear region is not well defined \n• the membrane surrounding bounds are not well defined \n\nEukaryotic cells:- • the size of these cells are generally large as compared with prokaryotic cells.\n• the nuclear region is well defined \n•the membrane surrounding bounds are well defined.\n 17 it seperate the contents of the cell from its external environment \nIt's allows which material will enter or exit the cell and is known as selectively permeable membrane \n18 plant cell :- it has cell wall \nLysosome are absent \nChloroplast,cromoplast and leucoplast are present .\nAnimal cell :- it don't have cell wall\nLysosome are present \nChloroplast cromoplast and leucoplast are absent \n19 nucleus is the brain 🧠 of cell which is also known as the control centre of the cell \nIt's has cromatin material ,nucleoid and nucleolus present in it \nIt's function  it stores  DNA which stores the genetic information and it also has the ribosome which help in protein synthesis.\n20 the spontaneous movement of water in the cell through the region of higher concentration to the region of lower concentration is called osmosis ex absorption of water by roots \n21 plastids are only present in plants which store starch ,oils etc\n22 endoplasmic reticulum is also known as ER which form network membrane bound tubes and sheets within cell . There are two types of ER \n•rough endoplasmic reticulum RER \n• smooth endoplasmic reticulum SER \nRER is rough  because it have ribosomes which help in protein synthesis \nSER is smooth because they don't have these ribosomes present in them\n 23 golgi apparatus \nCell wall \nLysosome \nVacuole \nRibosomes \nNucleus \nMitochondria \nNuclear membrane \nDNA\n24 it is outer covering of the cell\n25 the shrinkage of cytoplasm from the cell wall under hypertonic solution is known as plasmolysis \n26 mitochondria is called the powerhouse of cell because here energy is converted into ATP\n27 1 osmosis\n2 the water surrounding the cell has more concentration of water as compared to the water present inside the cell \n3 the cell will shrink because sugar solution has lower concentration of water and swollen cell have more water concentration \n4 they will shrink \n5 when we boil potatoes the potatoes will swell up.\nAbsorption of water 	\N	2025-05-18 08:17:44.364941
1021	46		\N	2025-05-18 08:17:53.29019
1022	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n17. The outermost covering of cell is called plasma membrane \n It is also known as  selectively permeable membrane \nfunction= it allows some substance to enter or exit \n16. Prokaryotic cell= 1. it have no nucleus\n                      2. It is present in  small organisms like bacteria,fungi etc\nEukaryotic cell=1. It have nucleus \n                2. It is present in organism like animal,plants etc\n18. Plant cell= 1. It covered by  cell wall \n                2. It  have mitochondria \nAnimal cell = 1.it covered by plasma membrane \n              2. It doesn't not have mitochondria\n22. It have to type of  endoplasmic reticulum \n1. Rough endoplasmic reticulum \n2.smooth endoplasmic reticulum \n19.it contain the cell's hereditary information and control of cell 's growth and reproduction \n21.plastid are double membrane organelles which found in the cell plant and algae\nIt have three types1. Chromoplast second chloroplast 3rd	\N	2025-05-18 08:18:04.297205
1023	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n17. The outermost covering of cell is called plasma membrane \n It is also known as  selectively permeable membrane \nfunction= it allows some substance to enter or exit \n16. Prokaryotic cell= 1. it have no nucleus\n                      2. It is present in  small organisms like bacteria,fungi etc\nEukaryotic cell=1. It have nucleus \n                2. It is present in organism like animal,plants etc\n18. Plant cell= 1. It covered by  cell wall \n                2. It  have mitochondria \nAnimal cell = 1.it covered by plasma membrane \n              2. It doesn't not have mitochondria\n22. It have to type of  endoplasmic reticulum \n1. Rough endoplasmic reticulum \n2.smooth endoplasmic reticulum \n19.it contain the cell's hereditary information and control of cell 's growth and reproduction \n21.plastid are double membrane organelles which found in the cell plant and algae\nIt have three types1. Chromoplast second chloroplast 3rd leucoplast	\N	2025-05-18 08:18:34.585056
1024	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n17. The outermost covering of cell is called plasma membrane \n It is also known as  selectively permeable membrane \nfunction= it allows some substance to enter or exit \n16. Prokaryotic cell= 1. it have no nucleus\n                      2. It is present in  small organisms like bacteria,fungi etc\nEukaryotic cell=1. It have nucleus \n                2. It is present in organism like animal,plants etc\n18. Plant cell= 1. It covered by  cell wall \n                2. It  have mitochondria \nAnimal cell = 1.it covered by plasma membrane \n              2. It doesn't not have mitochondria\n22. It have to type of  endoplasmic reticulum \n1. Rough endoplasmic reticulum \n2.smooth endoplasmic reticulum \n19.it contain the cell's hereditary information and control of cell 's growth and reproduction \n21.plastid are double membrane organelles which found in the cell plant and algae\nIt have three types1. Chromoplast second chloroplast 3rd leucoplast\n Section D\n23.	\N	2025-05-18 08:19:04.610061
1025	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n17. The outermost covering of cell is called plasma membrane \n It is also known as  selectively permeable membrane \nfunction= it allows some substance to enter or exit \n16. Prokaryotic cell= 1. it have no nucleus\n                      2. It is present in  small organisms like bacteria,fungi etc\nEukaryotic cell=1. It have nucleus \n                2. It is present in organism like animal,plants etc\n18. Plant cell= 1. It covered by  cell wall \n                2. It  have mitochondria \nAnimal cell = 1.it covered by plasma membrane \n              2. It doesn't not have mitochondria\n22. It have to type of  endoplasmic reticulum \n1. Rough endoplasmic reticulum \n2.smooth endoplasmic reticulum \n19.it contain the cell's hereditary information and control of cell 's growth and reproduction \n21.plastid are double membrane organelles which found in the cell plant and algae\nIt have three types1. Chromoplast second chloroplast 3rd leucoplast\n Section D\n23.sm	\N	2025-05-18 08:21:34.585611
1026	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n17. The outermost covering of cell is called plasma membrane \n It is also known as  selectively permeable membrane \nfunction= it allows some substance to enter or exit \n16. Prokaryotic cell= 1. it have no nucleus\n                      2. It is present in  small organisms like bacteria,fungi etc\nEukaryotic cell=1. It have nucleus \n                2. It is present in organism like animal,plants etc\n18. Plant cell= 1. It covered by  cell wall \n                2. It  have mitochondria \nAnimal cell = 1.it covered by plasma membrane \n              2. It doesn't not have mitochondria\n22. It have to type of  endoplasmic reticulum \n1. Rough endoplasmic reticulum \n2.smooth endoplasmic reticulum \n19.it contain the cell's hereditary information and control of cell 's growth and reproduction \n21.plastid are double membrane organelles which found in the cell plant and algae\nIt have three types1. Chromoplast second chloroplast 3rd leucoplast\n Section D\n23.smooth endoplasmic reticulum =	\N	2025-05-18 08:22:05.138825
1027	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n17. The outermost covering of cell is called plasma membrane \n It is also known as  selectively permeable membrane \nfunction= it allows some substance to enter or exit \n16. Prokaryotic cell= 1. it have no nucleus\n                      2. It is present in  small organisms like bacteria,fungi etc\nEukaryotic cell=1. It have nucleus \n                2. It is present in organism like animal,plants etc\n18. Plant cell= 1. It covered by  cell wall \n                2. It  have mitochondria \nAnimal cell = 1.it covered by plasma membrane \n              2. It doesn't not have mitochondria\n22. It have to type of  endoplasmic reticulum \n1. Rough endoplasmic reticulum \n2.smooth endoplasmic reticulum \n19.it contain the cell's hereditary information and control of cell 's growth and reproduction \n21.plastid are double membrane organelles which found in the cell plant and algae\nIt have three types1. Chromoplast second chloroplast 3rd leucoplast\n Section D\n23. =	\N	2025-05-18 08:25:33.674694
1028	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n17. The outermost covering of cell is called plasma membrane \n It is also known as  selectively permeable membrane \nfunction= it allows some substance to enter or exit \n16. Prokaryotic cell= 1. it have no nucleus\n                      2. It is present in  small organisms like bacteria,fungi etc\nEukaryotic cell=1. It have nucleus \n                2. It is present in organism like animal,plants etc\n18. Plant cell= 1. It covered by  cell wall \n                2. It  have mitochondria \nAnimal cell = 1.it covered by plasma membrane \n              2. It doesn't not have mitochondria\n22. It have to type of  endoplasmic reticulum \n1. Rough endoplasmic reticulum \n2.smooth endoplasmic reticulum \n19.it contain the cell's hereditary information and control of cell 's growth and reproduction \n21.plastid are double membrane organelles which found in the cell plant and algae\nIt have three types1. Chromoplast second chloroplast 3rd leucoplast\n Section D\n23. golgi apparatus  = i	\N	2025-05-18 08:26:33.305561
1029	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n17. The outermost covering of cell is called plasma membrane \n It is also known as  selectively permeable membrane \nfunction= it allows some substance to enter or exit \n16. Prokaryotic cell= 1. it have no nucleus\n                      2. It is present in  small organisms like bacteria,fungi etc\nEukaryotic cell=1. It have nucleus \n                2. It is present in organism like animal,plants etc\n18. Plant cell= 1. It covered by  cell wall \n                2. It  have mitochondria \nAnimal cell = 1.it covered by plasma membrane \n              2. It doesn't not have mitochondria\n22. It have to type of  endoplasmic reticulum \n1. Rough endoplasmic reticulum \n2.smooth endoplasmic reticulum \n19.it contain the cell's hereditary information and control of cell 's growth and reproduction \n21.plastid are double membrane organelles which found in the cell plant and algae\nIt have three types1. Chromoplast second chloroplast 3rd leucoplast\n Section D\n23. golgi apparatus  = it help in packing and dispac	\N	2025-05-18 08:27:03.92022
1030	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n17. The outermost covering of cell is called plasma membrane \n It is also known as  selectively permeable membrane \nfunction= it allows some substance to enter or exit \n16. Prokaryotic cell= 1. it have no nucleus\n                      2. It is present in  small organisms like bacteria,fungi etc\nEukaryotic cell=1. It have nucleus \n                2. It is present in organism like animal,plants etc\n18. Plant cell= 1. It covered by  cell wall \n                2. It  have mitochondria \nAnimal cell = 1.it covered by plasma membrane \n              2. It doesn't not have mitochondria\n22. It have to type of  endoplasmic reticulum \n1. Rough endoplasmic reticulum \n2.smooth endoplasmic reticulum \n19.it contain the cell's hereditary information and control of cell 's growth and reproduction \n21.plastid are double membrane organelles which found in the cell plant and algae\nIt have three types1. Chromoplast second chloroplast 3rd leucoplast\n Section D\n23. golgi apparatus  = it help in packing and dispacking of cell \nMi	\N	2025-05-18 08:27:33.218209
1031	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n17. The outermost covering of cell is called plasma membrane \n It is also known as  selectively permeable membrane \nfunction= it allows some substance to enter or exit \n16. Prokaryotic cell= 1. it have no nucleus\n                      2. It is present in  small organisms like bacteria,fungi etc\nEukaryotic cell=1. It have nucleus \n                2. It is present in organism like animal,plants etc\n18. Plant cell= 1. It covered by  cell wall \n                2. It  have mitochondria \nAnimal cell = 1.it covered by plasma membrane \n              2. It doesn't not have mitochondria\n22. It have to type of  endoplasmic reticulum \n1. Rough endoplasmic reticulum \n2.smooth endoplasmic reticulum \n19.it contain the cell's hereditary information and control of cell 's growth and reproduction \n21.plastid are double membrane organelles which found in the cell plant and algae\nIt have three types1. Chromoplast second chloroplast 3rd leucoplast\n Section D\n23. golgi apparatus  = it help in packing and dispacking  mitrochondr\n	\N	2025-05-18 08:28:03.118241
1032	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n17. The outermost covering of cell is called plasma membrane \n It is also known as  selectively permeable membrane \nfunction= it allows some substance to enter or exit \n16. Prokaryotic cell= 1. it have no nucleus\n                      2. It is present in  small organisms like bacteria,fungi etc\nEukaryotic cell=1. It have nucleus \n                2. It is present in organism like animal,plants etc\n18. Plant cell= 1. It covered by  cell wall \n                2. It  have mitochondria \nAnimal cell = 1.it covered by plasma membrane \n              2. It doesn't not have mitochondria\n22. It have to type of  endoplasmic reticulum \n1. Rough endoplasmic reticulum \n2.smooth endoplasmic reticulum \n19.it contain the cell's hereditary information and control of cell 's growth and reproduction \n21.plastid are double membrane organelles which found in the cell plant and algae\nIt have three types1. Chromoplast second chloroplast 3rd leucoplast\n Section D\n23. golgi apparatus  = it help in packing and dispacking  \nMitochondria= \n	\N	2025-05-18 08:28:34.050234
1033	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n17. The outermost covering of cell is called plasma membrane \n It is also known as  selectively permeable membrane \nfunction= it allows some substance to enter or exit \n16. Prokaryotic cell= 1. it have no nucleus\n                      2. It is present in  small organisms like bacteria,fungi etc\nEukaryotic cell=1. It have nucleus \n                2. It is present in organism like animal,plants etc\n18. Plant cell= 1. It covered by  cell wall \n                2. It  have mitochondria \nAnimal cell = 1.it covered by plasma membrane \n              2. It doesn't not have mitochondria\n22. It have to type of  endoplasmic reticulum \n1. Rough endoplasmic reticulum \n2.smooth endoplasmic reticulum \n19.it contain the cell's hereditary information and control of cell 's growth and reproduction \n21.plastid are double membrane organelles which found in the cell plant and algae\nIt have three types1. Chromoplast second chloroplast 3rd leucoplast\n Section D\n23. golgi apparatus  = it help in packing and dispacking  \nMitochondria=  it is power house of cell\n\n	\N	2025-05-18 08:29:03.134629
1034	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n17. The outermost covering of cell is called plasma membrane \n It is also known as  selectively permeable membrane \nfunction= it allows some substance to enter or exit \n16. Prokaryotic cell= 1. it have no nucleus\n                      2. It is present in  small organisms like bacteria,fungi etc\nEukaryotic cell=1. It have nucleus \n                2. It is present in organism like animal,plants etc\n18. Plant cell= 1. It covered by  cell wall \n                2. It  have mitochondria \nAnimal cell = 1.it covered by plasma membrane \n              2. It doesn't not have mitochondria\n22. It have to type of  endoplasmic reticulum \n1. Rough endoplasmic reticulum \n2.smooth endoplasmic reticulum \n19.it contain the cell's hereditary information and control of cell 's growth and reproduction \n21.plastid are double membrane organelles which found in the cell plant and algae\nIt have three types1. Chromoplast second chloroplast 3rd leucoplast\n Section D\n23. golgi apparatus  = it help in packing and dispacking  \nMitochondria=  it is power house of cell\n25.\n	\N	2025-05-18 08:29:33.199136
1035	45	 Section A \n1. Cell\n2.cell wall\n3. mitochondria \n4. Synthesize protein \n5.cytoplasm\n6.golgi apparatus \n7.plant\n8. nucleus\n9.osmosis\n10.ribosomes \nSection B\n11.  Both A and R are true but R is  not correct explanation of A\n12. Both A and R are is ture but R is not correct explanation of A \n13.A is true and R is also true\n14.A is true and R is false\n15.A is true and R is false\nSection C \n20. The spontaneous movement of   cell  in water from   higher water concentration to lower water concentration is called osmosis \n17. The outermost covering of cell is called plasma membrane \n It is also known as  selectively permeable membrane \nfunction= it allows some substance to enter or exit \n16. Prokaryotic cell= 1. it have no nucleus\n                      2. It is present in  small organisms like bacteria,fungi etc\nEukaryotic cell=1. It have nucleus \n                2. It is present in organism like animal,plants etc\n18. Plant cell= 1. It covered by  cell wall \n                2. It  have mitochondria \nAnimal cell = 1.it covered by plasma membrane \n              2. It doesn't not have mitochondria\n22. It have to type of  endoplasmic reticulum \n1. Rough endoplasmic reticulum \n2.smooth endoplasmic reticulum \n19.it contain the cell's hereditary information and control of cell 's growth and reproduction \n21.plastid are double membrane organelles which found in the cell plant and algae\nIt have three types1. Chromoplast second chloroplast 3rd leucoplast\n Section D\n23. golgi apparatus  = it help in packing and dispacking  \nMitochondria=  it is power house of cell\n26.\n	\N	2025-05-18 08:30:03.397263
1036	45		\N	2025-05-18 08:33:23.513977
1038	55	Hello	\N	2025-05-18 16:58:52.203007
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: tuition_db_5_user
--

COPY public."user" (id, username, password, role, is_admin) FROM stdin;
1	Vineet Admin	pbkdf2:sha256:1000000$9MCHmpCFWbmJNHV6$74e3da45a3fd4f37e19b41cabaed31ee96cc698941b63d1fc6e23ed61dc21743	admin	f
4	Kusum Soni Admin	pbkdf2:sha256:1000000$dozGuQAn7t28NHVy$148cbe9aad41e88ab7d293e8029bd2597262ae2ff7705ab0726d8c15823641ae	admin	f
37	Samiha	pbkdf2:sha256:1000000$6NVhMb7o4lqzxrEv$88a2695d20c0281322dace1273df7a758ffa1fca74f6e247b8c8e63128ad92c7	student	f
39	Greesha	pbkdf2:sha256:1000000$AaUcJVdTMruzpY4X$731da2ead4a8244bcdeffc8ad35e48d833b2101423baf093cbea7901b222a64a	student	f
42	Ekam	pbkdf2:sha256:1000000$c4ijnOR4ue5uuz0m$3e829bc49d5612615fffbcce02625dc6ab49efecec72d5efa09e772363fc3a40	student	f
44	Ravneet	pbkdf2:sha256:1000000$8PA2tqUc7FZ4a0y0$e7f9102e1b8a863dbbad257b1fb1a0405a8dea24f9be4d41b4d10268592da7a7	student	f
47	Tamanna	pbkdf2:sha256:1000000$3RdnkIkwgS0Y7fci$d61e6d8585acb03bf07dfb5b6ca9af55d6a538ee6ebcb4445e8fb4466ed1a9c4	student	f
49	Diya	pbkdf2:sha256:1000000$eKy9atp0LjLLWTtD$c8ba335f1b0e80438e7e74d75ea8bf0df964b72737a4b174364af3afcb1bdce1	student	f
50	Freya	pbkdf2:sha256:1000000$jYgvvkgvoOuCbveZ$b4c2b03087e8842642ca862455434567bb31825d6e67dd9a4a6da32ee8b4fcd5	student	f
51	abc	pbkdf2:sha256:1000000$OvtWwX3g70YP2RFJ$61f6d0aa4068dce64e36340d77a4cc2f88ba5d1a096acf8ca71cd7b89a8df4d4	student	f
52	def	pbkdf2:sha256:1000000$vQKPkVf8VWV02yVI$7d1b9c6109274c631b41532e9355b9e3f573b7f0f5b6484a43ccb129dfc16a2f	student	f
\.


--
-- Data for Name: video_lecture; Type: TABLE DATA; Schema: public; Owner: tuition_db_5_user
--

COPY public.video_lecture (id, title, description, filename, youtube_url, date_added, admin_id, chapter_id) FROM stdin;
3	Life Processes- 1	Introduction to Autotrophic nutrition 🌱🪴	\N	https://youtu.be/4rXmEi0jzlc?si=6tbWqo64IfxejFwc	2025-04-05 12:33:21.250416	4	1
4	Life Processes - 2	Nutrition in plants and animals 🌱🦅	\N	https://youtu.be/z5V5E4vKpCU?si=C6xRCzCrScEFMCM2	2025-04-05 12:35:34.236318	4	1
5	Real Numbers (1)	Real Numbers part 1	\N	https://youtu.be/IO1IcOAGw7w?si=cs9OcSG-0UsfH9as	2025-04-12 06:06:33.966224	4	2
6	Life Processes (3)	How do plants make their food?	\N	https://youtu.be/PTKWfPRpygg?si=DEHQcV7dIKH2FgTw	2025-04-12 06:07:56.672933	4	1
7	Motion (1)	Introduction to the concepts of motion	\N	https://youtu.be/kCMdwQM-Cz8?si=QndB5DTcklZ_VAL7	2025-04-12 10:33:50.098685	4	3
8	Real Numbers (2)	Proving that a number is irrational	\N	https://youtu.be/urzTmBOXQwQ?si=068b-eG-vHn3j6K4	2025-04-12 10:38:30.074714	4	2
9	Polynomials (1)	Polynomials and its types 	\N	https://youtu.be/-MzG3xTk018?si=DAOCltD770nFATLz	2025-04-12 17:00:42.674974	4	4
10	Polynomials (2)	Roots and their relation with coefficient 	\N	https://youtu.be/Gu5ig13T_mQ?si=r6A4t6i8X_7ttI_M	2025-04-12 17:02:17.434612	4	4
11	Polynomials (3)	Continuation of the previous lecture	\N	https://youtu.be/0MSd29c2390?si=sr7RC8PhPxGQMj_V	2025-04-12 17:04:48.019818	4	4
12	Polynomials (4)	Sum of roots and product of roots	\N	https://youtu.be/Iv02RU4YJn0?si=MxEw1dBZGaHVk7k2	2025-04-12 17:05:44.553073	4	4
13	Motion (2)	Questions on Motion Solved	\N	https://youtu.be/v9AsIyZbgmg?si=Xdz-uJPxzjkdN-Uy	2025-05-10 09:04:20.284841	4	3
\.


--
-- Name: announcement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tuition_db_5_user
--

SELECT pg_catalog.setval('public.announcement_id_seq', 5, true);


--
-- Name: chapter_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tuition_db_5_user
--

SELECT pg_catalog.setval('public.chapter_id_seq', 4, true);


--
-- Name: live_question_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tuition_db_5_user
--

SELECT pg_catalog.setval('public.live_question_id_seq', 1, false);


--
-- Name: live_response_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tuition_db_5_user
--

SELECT pg_catalog.setval('public.live_response_id_seq', 1, false);


--
-- Name: live_test_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tuition_db_5_user
--

SELECT pg_catalog.setval('public.live_test_id_seq', 1, true);


--
-- Name: live_test_participant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tuition_db_5_user
--

SELECT pg_catalog.setval('public.live_test_participant_id_seq', 1, false);


--
-- Name: payment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tuition_db_5_user
--

SELECT pg_catalog.setval('public.payment_id_seq', 4, true);


--
-- Name: student_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tuition_db_5_user
--

SELECT pg_catalog.setval('public.student_id_seq', 32, true);


--
-- Name: subject_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tuition_db_5_user
--

SELECT pg_catalog.setval('public.subject_id_seq', 3, true);


--
-- Name: test_assignment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tuition_db_5_user
--

SELECT pg_catalog.setval('public.test_assignment_id_seq', 105, true);


--
-- Name: test_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tuition_db_5_user
--

SELECT pg_catalog.setval('public.test_id_seq', 53, true);


--
-- Name: test_response_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tuition_db_5_user
--

SELECT pg_catalog.setval('public.test_response_id_seq', 1200, true);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tuition_db_5_user
--

SELECT pg_catalog.setval('public.user_id_seq', 55, true);


--
-- Name: video_lecture_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tuition_db_5_user
--

SELECT pg_catalog.setval('public.video_lecture_id_seq', 13, true);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: tuition_db_5_user
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: announcement announcement_pkey; Type: CONSTRAINT; Schema: public; Owner: tuition_db_5_user
--

ALTER TABLE ONLY public.announcement
    ADD CONSTRAINT announcement_pkey PRIMARY KEY (id);


--
-- Name: chapter chapter_pkey; Type: CONSTRAINT; Schema: public; Owner: tuition_db_5_user
--

ALTER TABLE ONLY public.chapter
    ADD CONSTRAINT chapter_pkey PRIMARY KEY (id);


--
-- Name: live_question live_question_pkey; Type: CONSTRAINT; Schema: public; Owner: tuition_db_5_user
--

ALTER TABLE ONLY public.live_question
    ADD CONSTRAINT live_question_pkey PRIMARY KEY (id);


--
-- Name: live_response live_response_pkey; Type: CONSTRAINT; Schema: public; Owner: tuition_db_5_user
--

ALTER TABLE ONLY public.live_response
    ADD CONSTRAINT live_response_pkey PRIMARY KEY (id);


--
-- Name: live_test_participant live_test_participant_pkey; Type: CONSTRAINT; Schema: public; Owner: tuition_db_5_user
--

ALTER TABLE ONLY public.live_test_participant
    ADD CONSTRAINT live_test_participant_pkey PRIMARY KEY (id);


--
-- Name: live_test live_test_pkey; Type: CONSTRAINT; Schema: public; Owner: tuition_db_5_user
--

ALTER TABLE ONLY public.live_test
    ADD CONSTRAINT live_test_pkey PRIMARY KEY (id);


--
-- Name: payment payment_pkey; Type: CONSTRAINT; Schema: public; Owner: tuition_db_5_user
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_pkey PRIMARY KEY (id);


--
-- Name: student student_pkey; Type: CONSTRAINT; Schema: public; Owner: tuition_db_5_user
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_pkey PRIMARY KEY (id);


--
-- Name: subject subject_pkey; Type: CONSTRAINT; Schema: public; Owner: tuition_db_5_user
--

ALTER TABLE ONLY public.subject
    ADD CONSTRAINT subject_pkey PRIMARY KEY (id);


--
-- Name: test_assignment test_assignment_pkey; Type: CONSTRAINT; Schema: public; Owner: tuition_db_5_user
--

ALTER TABLE ONLY public.test_assignment
    ADD CONSTRAINT test_assignment_pkey PRIMARY KEY (id);


--
-- Name: test test_pkey; Type: CONSTRAINT; Schema: public; Owner: tuition_db_5_user
--

ALTER TABLE ONLY public.test
    ADD CONSTRAINT test_pkey PRIMARY KEY (id);


--
-- Name: test_response test_response_pkey; Type: CONSTRAINT; Schema: public; Owner: tuition_db_5_user
--

ALTER TABLE ONLY public.test_response
    ADD CONSTRAINT test_response_pkey PRIMARY KEY (id);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: tuition_db_5_user
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: user user_username_key; Type: CONSTRAINT; Schema: public; Owner: tuition_db_5_user
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key UNIQUE (username);


--
-- Name: video_lecture video_lecture_pkey; Type: CONSTRAINT; Schema: public; Owner: tuition_db_5_user
--

ALTER TABLE ONLY public.video_lecture
    ADD CONSTRAINT video_lecture_pkey PRIMARY KEY (id);


--
-- Name: announcement announcement_admin_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tuition_db_5_user
--

ALTER TABLE ONLY public.announcement
    ADD CONSTRAINT announcement_admin_id_fkey FOREIGN KEY (admin_id) REFERENCES public."user"(id);


--
-- Name: chapter chapter_subject_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tuition_db_5_user
--

ALTER TABLE ONLY public.chapter
    ADD CONSTRAINT chapter_subject_id_fkey FOREIGN KEY (subject_id) REFERENCES public.subject(id);


--
-- Name: live_question live_question_live_test_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tuition_db_5_user
--

ALTER TABLE ONLY public.live_question
    ADD CONSTRAINT live_question_live_test_id_fkey FOREIGN KEY (live_test_id) REFERENCES public.live_test(id);


--
-- Name: live_response live_response_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tuition_db_5_user
--

ALTER TABLE ONLY public.live_response
    ADD CONSTRAINT live_response_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.live_question(id);


--
-- Name: live_response live_response_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tuition_db_5_user
--

ALTER TABLE ONLY public.live_response
    ADD CONSTRAINT live_response_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student(id);


--
-- Name: live_test live_test_admin_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tuition_db_5_user
--

ALTER TABLE ONLY public.live_test
    ADD CONSTRAINT live_test_admin_id_fkey FOREIGN KEY (admin_id) REFERENCES public."user"(id);


--
-- Name: live_test_participant live_test_participant_live_test_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tuition_db_5_user
--

ALTER TABLE ONLY public.live_test_participant
    ADD CONSTRAINT live_test_participant_live_test_id_fkey FOREIGN KEY (live_test_id) REFERENCES public.live_test(id);


--
-- Name: live_test_participant live_test_participant_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tuition_db_5_user
--

ALTER TABLE ONLY public.live_test_participant
    ADD CONSTRAINT live_test_participant_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student(id);


--
-- Name: payment payment_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tuition_db_5_user
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student(id);


--
-- Name: student student_teacher_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tuition_db_5_user
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_teacher_id_fkey FOREIGN KEY (teacher_id) REFERENCES public."user"(id);


--
-- Name: student student_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tuition_db_5_user
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: subject subject_admin_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tuition_db_5_user
--

ALTER TABLE ONLY public.subject
    ADD CONSTRAINT subject_admin_id_fkey FOREIGN KEY (admin_id) REFERENCES public."user"(id);


--
-- Name: test test_admin_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tuition_db_5_user
--

ALTER TABLE ONLY public.test
    ADD CONSTRAINT test_admin_id_fkey FOREIGN KEY (admin_id) REFERENCES public."user"(id);


--
-- Name: test_assignment test_assignment_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tuition_db_5_user
--

ALTER TABLE ONLY public.test_assignment
    ADD CONSTRAINT test_assignment_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student(id);


--
-- Name: test_assignment test_assignment_test_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tuition_db_5_user
--

ALTER TABLE ONLY public.test_assignment
    ADD CONSTRAINT test_assignment_test_id_fkey FOREIGN KEY (test_id) REFERENCES public.test(id);


--
-- Name: test_response test_response_assignment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tuition_db_5_user
--

ALTER TABLE ONLY public.test_response
    ADD CONSTRAINT test_response_assignment_id_fkey FOREIGN KEY (assignment_id) REFERENCES public.test_assignment(id);


--
-- Name: video_lecture video_lecture_admin_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tuition_db_5_user
--

ALTER TABLE ONLY public.video_lecture
    ADD CONSTRAINT video_lecture_admin_id_fkey FOREIGN KEY (admin_id) REFERENCES public."user"(id);


--
-- Name: video_lecture video_lecture_chapter_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tuition_db_5_user
--

ALTER TABLE ONLY public.video_lecture
    ADD CONSTRAINT video_lecture_chapter_id_fkey FOREIGN KEY (chapter_id) REFERENCES public.chapter(id);


--
-- Name: FUNCTION pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision) TO tuition_db_5_user;


--
-- Name: FUNCTION pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO tuition_db_5_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON SEQUENCES TO tuition_db_5_user;


--
-- Name: DEFAULT PRIVILEGES FOR TYPES; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON TYPES TO tuition_db_5_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON FUNCTIONS TO tuition_db_5_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO tuition_db_5_user;


--
-- PostgreSQL database dump complete
--

