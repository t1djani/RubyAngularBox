<?php

		$listAdverts = $repository->findBy(
			array(
				'lastname' => array(
					'balaba',
					ndjqsj,
					'jifoqjfqs'
					)
				), // Critere
			array('date' => 'desc'),        // Tri
			1,                              // Limite
			0                               // Offset
		);
