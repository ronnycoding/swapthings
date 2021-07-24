SET check_function_bodies = false;
CREATE FUNCTION public."set_current_timestamp_updatedAt"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."updatedAt" = NOW();
  RETURN _new;
END;
$$;
CREATE FUNCTION public.set_current_timestamp_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."updated_at" = NOW();
  RETURN _new;
END;
$$;
CREATE TABLE public.article_bids (
    "bidderId" uuid NOT NULL,
    "moneyOffer" integer,
    "articleOffer" uuid,
    "articleBidId" uuid DEFAULT public.gen_random_uuid() NOT NULL,
    "articleBidStatusId" text NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now(),
    "updatedAt" timestamp with time zone DEFAULT now(),
    "moneyCurrency" text
);
CREATE TABLE public.article_categories (
    "articleCategoryId" uuid DEFAULT public.gen_random_uuid() NOT NULL,
    "articleCategoryName" text NOT NULL,
    "articleCategoryImage" text NOT NULL,
    "articleCategoryDescription" text,
    "createdAt" timestamp with time zone DEFAULT now(),
    "updatedAt" timestamp with time zone DEFAULT now()
);
COMMENT ON TABLE public.article_categories IS 'Article Categories table';
CREATE TABLE public.article_sub_categories (
    "articleSubCategoryId" uuid DEFAULT public.gen_random_uuid() NOT NULL,
    "articleSubCategoryName" text NOT NULL,
    "articleSubCategoryDescription" text,
    "articleSubCategoryImage" text,
    "articleCategoryParent" uuid NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now(),
    "updatedAt" timestamp with time zone DEFAULT now()
);
COMMENT ON TABLE public.article_sub_categories IS 'Article Sub Categories Options';
CREATE TABLE public.articles (
    "articleId" uuid DEFAULT public.gen_random_uuid() NOT NULL,
    "articleName" text NOT NULL,
    "articleDescription" text NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    price integer NOT NULL,
    "articleSubCategoryId" uuid NOT NULL,
    "publisherId" uuid NOT NULL,
    "priceCurrency" text NOT NULL
);
COMMENT ON TABLE public.articles IS 'Articles table';
CREATE TABLE public.bid_statuses (
    "bidStatus" text NOT NULL
);
CREATE TABLE public.countries (
    country text NOT NULL
);
CREATE TABLE public.currencies (
    "currencyName" text NOT NULL,
    "currencyISO" text NOT NULL
);
COMMENT ON TABLE public.currencies IS 'Currencies Table';
CREATE TABLE public.languages (
    "languageName" text NOT NULL,
    "languageISO" text NOT NULL
);
CREATE TABLE public.provinces (
    "provinceName" text NOT NULL,
    "provinceISO" text NOT NULL,
    "countryId" text NOT NULL,
    "languageISO" text
);
CREATE TABLE public.submission_statuses (
    "submissionStatus" text NOT NULL
);
CREATE TABLE public.submissions (
    "submissionId" uuid DEFAULT public.gen_random_uuid() NOT NULL,
    "articleId" uuid NOT NULL,
    "submissionStatusId" text NOT NULL,
    "submitterId" uuid NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now(),
    "updatedAt" timestamp with time zone DEFAULT now()
);
CREATE TABLE public.towns (
    "townId" uuid DEFAULT public.gen_random_uuid() NOT NULL,
    "townName" text NOT NULL,
    "provinceISO" text NOT NULL
);
CREATE TABLE public.user_roles (
    "userRole" text NOT NULL
);
CREATE TABLE public.users (
    username text,
    avatar text,
    "firstName" text,
    "lastName" text,
    email text NOT NULL,
    "phoneNumber" text NOT NULL,
    "verifyEmail" boolean DEFAULT false NOT NULL,
    "verifyPhoneNumber" boolean DEFAULT false NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    "userId" uuid DEFAULT public.gen_random_uuid() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now(),
    "updatedAt" timestamp with time zone DEFAULT now(),
    "userRoleId" text NOT NULL
);
COMMENT ON TABLE public.users IS 'Users information table';
ALTER TABLE ONLY public.article_bids
    ADD CONSTRAINT "articleBids_pkey" PRIMARY KEY ("articleBidId");
ALTER TABLE ONLY public.article_categories
    ADD CONSTRAINT "article_categories_articleCategoryId_key" UNIQUE ("articleCategoryId");
ALTER TABLE ONLY public.article_categories
    ADD CONSTRAINT "article_categories_articleCategoryName_key" UNIQUE ("articleCategoryName");
ALTER TABLE ONLY public.article_categories
    ADD CONSTRAINT article_categories_pkey PRIMARY KEY ("articleCategoryId", "articleCategoryName");
ALTER TABLE ONLY public.article_sub_categories
    ADD CONSTRAINT "article_sub_categories_articleSubCategoryId_key" UNIQUE ("articleSubCategoryId");
ALTER TABLE ONLY public.article_sub_categories
    ADD CONSTRAINT "article_sub_categories_articleSubCategoryName_key" UNIQUE ("articleSubCategoryName");
ALTER TABLE ONLY public.article_sub_categories
    ADD CONSTRAINT article_sub_categories_pkey PRIMARY KEY ("articleSubCategoryId", "articleSubCategoryName");
ALTER TABLE ONLY public.articles
    ADD CONSTRAINT articles_pkey PRIMARY KEY ("articleId");
ALTER TABLE ONLY public.bid_statuses
    ADD CONSTRAINT "bid_statuses_bidStatusId_key" UNIQUE ("bidStatus");
ALTER TABLE ONLY public.bid_statuses
    ADD CONSTRAINT bid_statuses_pkey PRIMARY KEY ("bidStatus");
ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (country);
ALTER TABLE ONLY public.currencies
    ADD CONSTRAINT currencies_pkey PRIMARY KEY ("currencyISO");
ALTER TABLE ONLY public.languages
    ADD CONSTRAINT languages_pkey PRIMARY KEY ("languageISO");
ALTER TABLE ONLY public.provinces
    ADD CONSTRAINT provinces_pkey PRIMARY KEY ("provinceISO");
ALTER TABLE ONLY public.submission_statuses
    ADD CONSTRAINT "publicationStatuses_pkey" PRIMARY KEY ("submissionStatus");
ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT submissions_pkey PRIMARY KEY ("submissionId");
ALTER TABLE ONLY public.towns
    ADD CONSTRAINT towns_pkey PRIMARY KEY ("townId");
ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY ("userRole");
ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
ALTER TABLE ONLY public.users
    ADD CONSTRAINT "users_phoneNumber_key" UNIQUE ("phoneNumber");
ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY ("userId");
CREATE TRIGGER set_public_article_bids_updated_at BEFORE UPDATE ON public.article_bids FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_article_bids_updated_at ON public.article_bids IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE TRIGGER "set_public_article_categories_updatedAt" BEFORE UPDATE ON public.article_categories FOR EACH ROW EXECUTE FUNCTION public."set_current_timestamp_updatedAt"();
COMMENT ON TRIGGER "set_public_article_categories_updatedAt" ON public.article_categories IS 'trigger to set value of column "updatedAt" to current timestamp on row update';
CREATE TRIGGER "set_public_article_sub_categories_updatedAt" BEFORE UPDATE ON public.article_sub_categories FOR EACH ROW EXECUTE FUNCTION public."set_current_timestamp_updatedAt"();
COMMENT ON TRIGGER "set_public_article_sub_categories_updatedAt" ON public.article_sub_categories IS 'trigger to set value of column "updatedAt" to current timestamp on row update';
CREATE TRIGGER set_public_articles_updated_at BEFORE UPDATE ON public.articles FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_articles_updated_at ON public.articles IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE TRIGGER "set_public_submissions_updatedAt" BEFORE UPDATE ON public.submissions FOR EACH ROW EXECUTE FUNCTION public."set_current_timestamp_updatedAt"();
COMMENT ON TRIGGER "set_public_submissions_updatedAt" ON public.submissions IS 'trigger to set value of column "updatedAt" to current timestamp on row update';
CREATE TRIGGER set_public_users_updated_at BEFORE UPDATE ON public.users FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_users_updated_at ON public.users IS 'trigger to set value of column "updated_at" to current timestamp on row update';
ALTER TABLE ONLY public.article_bids
    ADD CONSTRAINT "article_bids_articleBidStatusId_fkey" FOREIGN KEY ("articleBidStatusId") REFERENCES public.bid_statuses("bidStatus") ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.article_bids
    ADD CONSTRAINT "article_bids_moneyCurrency_fkey" FOREIGN KEY ("moneyCurrency") REFERENCES public.currencies("currencyISO") ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.article_sub_categories
    ADD CONSTRAINT "article_sub_categories_articleCategoryParent_fkey" FOREIGN KEY ("articleCategoryParent") REFERENCES public.article_categories("articleCategoryId") ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.articles
    ADD CONSTRAINT "articles_articleSubCategoryId_fkey" FOREIGN KEY ("articleSubCategoryId") REFERENCES public.article_sub_categories("articleSubCategoryId") ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.articles
    ADD CONSTRAINT "articles_priceCurrency_fkey" FOREIGN KEY ("priceCurrency") REFERENCES public.currencies("currencyISO") ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.articles
    ADD CONSTRAINT "articles_publisherId_fkey" FOREIGN KEY ("publisherId") REFERENCES public.users("userId") ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.provinces
    ADD CONSTRAINT "provinces_countryId_fkey" FOREIGN KEY ("countryId") REFERENCES public.countries(country) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.provinces
    ADD CONSTRAINT "provinces_languageISO_fkey" FOREIGN KEY ("languageISO") REFERENCES public.languages("languageISO") ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT "submissions_submissionStatusId_fkey" FOREIGN KEY ("submissionStatusId") REFERENCES public.submission_statuses("submissionStatus") ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT "submissions_submitterId_fkey" FOREIGN KEY ("submitterId") REFERENCES public.users("userId") ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.towns
    ADD CONSTRAINT "towns_provinceISO_fkey" FOREIGN KEY ("provinceISO") REFERENCES public.provinces("provinceISO") ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.users
    ADD CONSTRAINT "users_userRoleId_fkey" FOREIGN KEY ("userRoleId") REFERENCES public.user_roles("userRole") ON UPDATE RESTRICT ON DELETE RESTRICT;
