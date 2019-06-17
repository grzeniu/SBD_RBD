select sel1.DANE_KLIENTA, sel1.DANE_PRACOWNIKA, count(*) as LICZBA_ROZMOW 
from
(select
	concat (k.Imie,' ', k.Nazwisko) as DANE_KLIENTA,
	concat (p.Imie,' ', p.Nazwisko) as DANE_PRACOWNIKA,
	o.WARTOSC as OCENA,
	r.DATA as DATA_ROZMOWY
	from Rozmowa r
	inner join Ocena o on r.Ocena_ID = o.Ocena_ID
	inner join Klient k on r.Pesel_Klient = k.Pesel_Klient
	inner join Pracownik p on r.Pesel_Pracownik = p.Pesel_Pracownik
	inner join Dział d on d.Dzial_ID = p.Dzial_ID
	where
	d.Nazwa_Dzialu IN ('IT','HR','Marketing') and
	o.WARTOSC >
		(select avg(o1.WARTOSC)
		from Rozmowa r1
		inner join Ocena o1 on r1.Ocena_ID = o1.Ocena_ID)
	) as sel1
group by DANE_KLIENTA, DANE_PRACOWNIKA
order by "LICZBA_ROZMOW" desc;
